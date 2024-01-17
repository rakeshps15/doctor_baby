import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void sendMailToParent() async {
  var url = 'http://10.0.2.2:8000/babyapp/send_mail_date/';

  try {
    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print('Email sending initiated.');
    } else {
      print('Failed to send email. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error sending email: $e');
  }
}
