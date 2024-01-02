import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

void main(){
  runApp(MaterialApp(home: RegPage(),));
}

class RegPage extends StatefulWidget {
  const RegPage({super.key});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {

  final email = TextEditingController();
  final pass = TextEditingController();
  final cpass = TextEditingController();
  late SharedPreferences preferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        centerTitle: true,
        title: Text("Signup",style: TextStyle(fontSize: 26, color: Colors.black, fontWeight: FontWeight.bold),),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          child: Container(
            padding: EdgeInsets.all(15),
            // color: Colors.white30,
            height: 600,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 25),

                Text("Create Account", style: TextStyle(color: Colors.blue, fontSize: 25),),

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
                    controller: pass,
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

                Text("Confirm Password",),

                SizedBox(height: 5),

                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25)
                  ),
                  child: TextField(
                    controller: cpass,
                    style: TextStyle(color: Colors.grey[600]),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                        isDense: true,
                        hintText: "Enter Confirm Password",
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
                      String eml  = email.text;
                      String pss  = pass.text;
                      String cpss = cpass.text;

                      if(eml != "" && pss != "" && cpss != ""){
                        preferences.setString("email", eml);
                        preferences.setString("pass", pss);
                        preferences.setString("cpass", cpss);

                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                      }
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
                    }, child: Text("Signin"))
                  ],
                )



              ],
            ),
          ),
        ),
      ),
    );
  }
}