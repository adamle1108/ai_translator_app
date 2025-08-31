import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../constant/AppAssets.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    super.key,
    required this.msg,
    this.isUser,
    required this.onTapVoice
  });
  final msg;
  final isUser;
  final VoidCallback onTapVoice;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
        children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 0),
            decoration: BoxDecoration(
              color: isUser ==true ? context.theme.cardColor : context.theme.focusColor.withOpacity(0.12),
              border: Border.all(
                color: Colors.grey.withOpacity(0.3),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: isUser == true
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.start,
                children: [
                  isUser == true
                      ? Icon(Icons.person,color: context.theme.hoverColor,)
                      : Row(
                    children: [
                      Image.asset(
                        AppAssets.splashImage,
                        height: 25,
                        width: 25,
                      ),
                      const Spacer(),
                      IconButton(onPressed: () {
                        Clipboard.setData(ClipboardData(text: msg));
                      }, icon: Icon(Icons.copy,color: context.theme.focusColor)),
                      GestureDetector(
                        onTap:onTapVoice,
                        child: Image.asset(AppAssets.soundIcon,height: 25,width: 25,color: context.theme.focusColor,),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    msg,
                    style: context.textTheme.titleSmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
