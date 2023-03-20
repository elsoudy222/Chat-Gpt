import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../shared/network/remote/dio_helper.dart';

class ChatGptScreen extends StatefulWidget {
  const ChatGptScreen({Key? key}) : super(key: key);

  @override
  State<ChatGptScreen> createState() => _ChatGptScreenState();
}

class _ChatGptScreenState extends State<ChatGptScreen> {
  List<String> list = [];
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ChatGPT"),
        centerTitle: true,
        backgroundColor: const Color(0xff343541),
      ),
      backgroundColor: const Color(0xff343541),
      body: SafeArea(
        child: Center(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      controller: scrollController,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              color: index % 2 == 0
                                  ? Colors.transparent
                                  : const Color(0xff434654),
                              padding: const EdgeInsets.all(10),
                              child: (ListTile(
                                  leading: CircleAvatar(
                                    child: Icon(
                                        index % 2 == 0
                                        ? Icons.account_circle
                                        : Icons.ac_unit
                                    ),
                                  ),
                                  title: index % 2 == 0
                                      ? Text(list[index])
                                      :AnimatedTextKit(
                                    animatedTexts: [
                                      TypewriterAnimatedText(
                                        list[index],
                                        speed: const Duration(milliseconds: 40),
                                      ),
                                    ],
                                    totalRepeatCount: 1,
                                  )
                              ))),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff343740),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey, //(x,y)
                            blurRadius: 0.1,
                          ),
                        ]),
                    padding: const EdgeInsets.all(9),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: messageController,
                            decoration: const InputDecoration.collapsed(
                                hintText: "Ask What You Want...."),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (messageController.text.isNotEmpty) {
                              setState(() {
                                list.add(messageController.text);
                              });
                            }
                            getResponse();
                          },
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );

  }

  getResponse() {
    if (messageController.text.isNotEmpty) {
      DioHelper.postData(
          url: "completions",
          data: {
            "model": "gpt-3.5-turbo",
            "messages": [{"role": "user", "content": messageController.text}]
            ,
            // "temperature": 0,
            // "max_tokens": 500
          }).then((value) {
        log(messageController.text);
        if (value.statusCode == 200) {
          setState(() {
            list.add(value.data["choices"][0]["message"]["content"]);
          });

        } else {
          log(value.toString());
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(value.statusMessage.toString())));
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Type Your Massage First")));
    }
    messageController.clear();
  }
}
