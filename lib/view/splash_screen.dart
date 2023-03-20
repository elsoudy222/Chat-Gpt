import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_gpt/view/chat_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AnimatedSplashScreen(
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assets/images/chatgpt.png",height: 50,),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  "WELCOME TO CHAT-GPT",
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                  speed: const Duration(milliseconds: 40),
                ),
              ],
              totalRepeatCount: 2,
            )
          ],
        ),
        nextScreen: const ChatGptScreen(),
      duration: 10,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: const Color(0xff343541),

    );
  }
}
