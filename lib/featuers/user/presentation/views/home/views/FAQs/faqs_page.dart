import 'package:flutter/material.dart';
import 'package:green_city/generated/l10n.dart';

import '../../../../../../../core/utils/constants.dart';
import '../../../../../../../core/themes/light_theme.dart';
import '../../../../../../../core/utils/text_style.dart';

class FAQsPage extends StatelessWidget {
  const FAQsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).faqs)),
      body: ListView.builder(
        itemCount: Constants.faqs.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Card(
              child: ExpansionTile(
                collapsedTextColor: MyColors.black,
                iconColor: MyColors.icons,
                title: Text(
                  Constants.faqs[index]["question"]!,
                  style: MyStyle.title18(context),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      Constants.faqs[index]["answer"]!,
                      style: MyStyle.title14(context),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
