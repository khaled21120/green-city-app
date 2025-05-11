import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:green_city/core/themes/dark_theme.dart';
import 'package:green_city/core/utils/constants.dart';
import 'package:green_city/core/utils/text_style.dart';
import 'package:green_city/featuers/auth/data/models/user_model.dart';
import 'package:green_city/generated/l10n.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/utils/endpoints.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final ChatUser currentUser;
  late final ChatUser botUser;
  late final GenerativeModel model;
  late final ChatSession chat;

  final List<ChatMessage> messages = [];
  final List<ChatUser> typingUsers = [];

  Future<void> onSend(ChatMessage message) async {
    setState(() {
      messages.insert(0, message);
      typingUsers.add(botUser);
    });

    try {
      final response = await chat.sendMessage(Content.text(message.text));

      final botReply = response.text ?? "I didn’t quite get that.";
      final botMessage = ChatMessage(
        user: botUser,
        createdAt: DateTime.now(),
        text: botReply,
      );

      setState(() {
        messages.insert(0, botMessage);
        typingUsers.clear();
      });
    } catch (e) {
      setState(() {
        messages.insert(
          0,
          ChatMessage(
            user: botUser,
            createdAt: DateTime.now(),
            text: 'Error: ${e.toString()}',
          ),
        );
        typingUsers.clear();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    currentUser = ChatUser(
      id: widget.userModel.id ?? '1',
      firstName: widget.userModel.name ?? 'User',
      profileImage: widget.userModel.profileImage ?? '',
    );

    botUser = ChatUser(
      id: 'bot',
      firstName: 'GreenCity Bot',
      profileImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgrf4DEg3ITHx54xcrZU2gzf6KmJJHtubLog&s',
    );

    model = GenerativeModel(
      model: 'gemini-2.0-flash-lite',
      apiKey: Endpoints.geminiAPI,
    );

    chat = model.startChat(history: [Content.text(Constants.appDescription)]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).assistant)),
      body: DashChat(
        currentUser: currentUser,
        onSend: onSend,
        messages: messages,
        typingUsers: typingUsers,
        inputOptions: InputOptions(
          inputTextStyle: MyStyle.title16(context),
          inputDecoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            suffixIconColor: Theme.of(context).colorScheme.primary,
            hintText: S.of(context).typeMessage,
          ),
        ),
        messageListOptions: MessageListOptions(
          dateSeparatorFormat: DateFormat.jm(),
        ),
        messageOptions: MessageOptions(
          showCurrentUserAvatar: true,
          currentUserContainerColor: MyColors.primary,
          currentUserTextColor: MyColors.white,
          containerColor: MyColors.darkGrey,
          textColor: MyColors.white,
          timeFormat: DateFormat.jm(),
          showTime: true,
        ),
      ),
    );
  }
}
