import 'package:doctor_baby/views/auth/registration.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _Login();
}
class _Login extends State<Login> {
  final email = TextEditingController();
  final pwd = TextEditingController();
  late SharedPreferences preferences;
  late bool newuser;

  late String storedemail;
  late String storedpass;

  @override
  void initState() {
    check_if_user_already_login();
    super.initState();
  }

  void check_if_user_already_login() async{
    preferences = await SharedPreferences.getInstance();

    newuser = preferences.getBool('newuser') ?? true;

    if(newuser == false){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>RegPage()));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[300],
        title: const Text("LOGIN PAGE",style: TextStyle(fontSize: 26, color: Colors.black, fontWeight: FontWeight.bold)),
      ),


      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          child: Container(
            padding: EdgeInsets.all(15),
            // color: Colors.white30,
            height: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 25),

                Text("Welcome User", style: TextStyle(color: Colors.blue, fontSize: 25),),

                const SizedBox(height: 25),

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
                            borderRadius: BorderRadius.circular(5)
                        ),
                        isDense: true,
                        hintText: "Enter Email",
                        fillColor: Colors.green
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                Text("Password",),

                SizedBox(height: 5),

                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25)
                  ),
                  child: TextField(
                    controller: pwd,
                    style: TextStyle(color: Colors.grey[600]),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                        isDense: true,
                        hintText: "Enter Password",
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
                      onPressed: () async {
                        preferences = await SharedPreferences.getInstance();
                        String username = email.text;
                        String password = pwd.text;

                        setState(() {
                          storedemail = preferences.getString('email')!;
                          storedpass = preferences.getString('pass')!;
                        });


                        if ((username != "" && username == storedemail) && (password != "" && password == storedpass)) {
                          preferences.setString('uname', username);
                          preferences.setString('pword', password);
                          preferences.setBool('newuser', false);

                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegPage())); // Navigate to RegPage after successful login
                        } else {
                          Fluttertoast.showToast(
                            msg: "Invalid Username or Password",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            backgroundColor: Colors.cyan,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                        email.text = "";
                        pwd.text = "";
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text("Login", style: TextStyle(color: Colors.white),),
                      )),
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
                      Text("Signin with Google", style: TextStyle(fontSize: 16),),
                    ],
                  ),),

              ],
            ),
          ),
        ),
      ),
    );
  }

}