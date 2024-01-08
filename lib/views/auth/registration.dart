import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login.dart';

void main() {
  runApp(MaterialApp(home: RegPage(), debugShowCheckedModeBanner: false));
}

class RegPage extends StatefulWidget {
  const RegPage({Key? key}) : super(key: key);

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  final user = TextEditingController();
  final first = TextEditingController();
  final last = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final pass = TextEditingController();

  Future<void> _registerUser() async {
    const String apiUrl = 'http://10.0.2.2:8000/babyapp/authtoken/';

    String userName = user.text;
    String firstName = first.text;
    String lastName = last.text;
    String userEmail = email.text;
    String userPhone = phone.text;
    String userPassword = pass.text;

    if (firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        userEmail.isNotEmpty &&
        userPhone.isNotEmpty &&
        userPassword.isNotEmpty) {
      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          body: {
            'username': userName,
            'first_name': firstName,
            'last_name': lastName,
            'email': userEmail,
            'phone': userPhone,
            'password': userPassword,
          },
        );

        if (response.statusCode == 201) {
          print('User registered successfully');
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
        } else {
          print('Failed to register user: ${response.statusCode}');
        }
      } catch (e) {
        print('Exception during registration: $e');
      }
    } else {
      print('All fields are required');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Text("Sign up", style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(15),
                  // color: Colors.white30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const SizedBox(height: 10),

                      Text("Create Account", style: TextStyle(color: Colors.blue, fontSize: 25),),

                      const SizedBox(height: 20),

                      Text("Username",),

                      SizedBox(height: 5),

                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child: TextField(
                          controller: user,
                          style: TextStyle(color: Colors.grey[600]),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              isDense: true,
                              hintText: "username",
                              fillColor: Colors.green
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text("First name",),

                      SizedBox(height: 5),

                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child: TextField(
                          controller: first,
                          style: TextStyle(color: Colors.grey[600]),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              isDense: true,
                              hintText: "first name",
                              fillColor: Colors.green
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      Text("Last name",),

                      SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child: TextField(
                          controller: last,
                          style: TextStyle(color: Colors.grey[600]),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              isDense: true,
                              hintText: "last name",
                              fillColor: Colors.green
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      Text("Email",),

                      SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child: TextField(
                          controller: email,
                          style: TextStyle(color: Colors.grey[600]),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              isDense: true,
                              hintText: "email",
                              fillColor: Colors.green
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      Text("Phone number"),

                      SizedBox(height: 5),

                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child: TextField(
                          controller: phone,
                          style: TextStyle(color: Colors.grey[600]),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              isDense: true,
                              hintText: "phone number",
                              fillColor: Colors.green
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      Text("Password",),

                      SizedBox(height: 5),

                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child: TextField(
                          controller: pass,
                          style: TextStyle(color: Colors.grey[600]),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              isDense: true,
                              hintText: "password",
                              fillColor: Colors.green
                          ),
                        ),
                      ),



                      const SizedBox(height: 25),


                      Padding(
                        padding: const EdgeInsets.only(left: 35),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue[700]),
                            fixedSize: MaterialStateProperty.all(Size(250, 40)),
                          ),
                          onPressed: () {
                            _registerUser();
                          },
                          child: const Text("SIGNUP", style: TextStyle(color: Colors.white)),
                        ),
                      ),


                      SizedBox(height: 20),

                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                height: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text("OR"),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),


                      SizedBox(height: 20,),

                      Container(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/google.png",height: 25),
                            SizedBox(width: 25),
                            Text("Signup with Google", style: TextStyle(fontSize: 16),),
                          ],
                        ),),

                      SizedBox(height: 10,),

                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?"),
                          TextButton(onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                          }, child: Text("Sign in"))
                        ],
                      )

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}