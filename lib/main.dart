import 'package:chat_gpt/shared/network/remote/dio_helper.dart';
import 'package:chat_gpt/view/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
 DioHelper.init();
  runApp(const MyApp());
}
// Edit
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatGPT',
      theme: ThemeData.dark(),
      home: const SplashScreen(),
    );
  }
}





