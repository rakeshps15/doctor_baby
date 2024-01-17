import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxList<Map<String, String>> chat = <Map<String, String>>[].obs;

  TextEditingController textController = TextEditingController();
  RxString text = ''.obs;
  RxString prediction = ''.obs;

  Future<void> postData(String text) async {
    var url = "http://10.0.2.2:8000/babyapp/chatbot/";
    chat.add({
      "responeby": "user",
      "text": text,
    });
    try {
      final jsonResponse = await http.post(
        Uri.parse(url),
        body: {'user_input': text.trim()},
      );

      if (jsonResponse.statusCode == 200) {
        Map<String, dynamic> parsedResponse = jsonDecode(jsonResponse.body);
        String responseValue = await parsedResponse['response'];
        chat.add({
          "responeby": "bot",
          "text": responseValue,
        });
        print(responseValue);
      } else {
        print("Error: ${jsonResponse.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}

class ChatBot extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          "Baby Helper",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() => ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: chatController.chat.length,
                  itemBuilder: (context, index) {
                    String chatText = chatController.chat[index]["text"]!;
                    return Align(
                      alignment: chatController.chat[index]["responeby"] == "bot"
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: chatController.chat[index]["responeby"] == "bot"
                                  ? Colors.blue
                                  : Colors.grey,
                              borderRadius: chatController.chat[index]["responeby"] ==
                                      "bot"
                                  ? BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      topRight: Radius.circular(10))
                                  : BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      topLeft: Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, bottom: 8, left: 15, right: 15),
                              child: Text(
                                chatText,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: chatController.textController,
                    onChanged: (value) => chatController.text.value = value,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter here ..",
                    ),
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    chatController.postData(chatController.text.value);
                    chatController.textController.text = "";
                  },
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.blue,
                    child: Center(child: Icon(Icons.send)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(GetMaterialApp(home: ChatBot()));
}
