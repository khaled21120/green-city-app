import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:green_city/core/utils/text_style.dart';
import 'package:green_city/featuers/auth/data/models/user_model.dart';
import 'package:green_city/core/utils/endpoints.dart';
import 'package:green_city/generated/l10n.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../../../../../../../core/utils/constants.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final types.User currentUser;
  late final types.User botUser;
  late final GenerativeModel model;
  late final ChatSession chat;

  final List<types.Message> _messages = [];
  bool _isBotTyping = false;

  @override
  void initState() {
    super.initState();

    currentUser = types.User(
      id: widget.userModel.id ?? '1',
      firstName: widget.userModel.name ?? 'User',
      imageUrl: widget.userModel.profileImage,
    );

    botUser = const types.User(
      id: 'bot',
      firstName: 'GreenCity Bot',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgrf4DEg3ITHx54xcrZU2gzf6KmJJHtubLog&s',
    );

    model = GenerativeModel(
      model: 'gemini-2.0-flash-lite',
      apiKey: Endpoints.geminiAPI,
    );

    chat = model.startChat(history: [Content.text(Constants.appDescription)]);
  }

  void _onSendPressed(types.PartialText message) async {
    final userMsg = types.TextMessage(
      author: currentUser,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    setState(() {
      _messages.insert(0, userMsg);
      _isBotTyping = true;
    });

    try {
      final response = await chat.sendMessage(Content.text(message.text));

      final reply = response.text ?? "I didn’t quite get that.";
      final botMsg = types.TextMessage(
        author: botUser,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: reply,
      );

      setState(() {
        _messages.insert(0, botMsg);
        _isBotTyping = false;
      });
    } catch (e) {
      final errorMsg = types.TextMessage(
        author: botUser,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: 'Error: ${e.toString()}',
      );

      setState(() {
        _messages.insert(0, errorMsg);
        _isBotTyping = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).assistant)),
      body: Column(
        children: [
          Expanded(
            child: Chat(
              messages: _messages,
              onSendPressed: _onSendPressed,
              user: currentUser,
              showUserAvatars: true,
              showUserNames: true,
              timeFormat: DateFormat.jm(),
              theme: DefaultChatTheme(
                inputTextDecoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ),
                backgroundColor: Theme.of(context).colorScheme.surface,
                primaryColor: Theme.of(context).colorScheme.primary,
                secondaryColor: Colors.black54,
                receivedMessageBodyTextStyle: MyStyle.title14(context),
                sentMessageBodyTextStyle: MyStyle.title14(context),
                inputTextStyle: MyStyle.title14(context),
              ),
            ),
          ),
          if (_isBotTyping)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  const CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgrf4DEg3ITHx54xcrZU2gzf6KmJJHtubLog&s',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'GreenCity Bot is typing...',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
