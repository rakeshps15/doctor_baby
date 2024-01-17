import 'package:doctor_baby/view/bottom_nav.dart';
import 'package:doctor_baby/view/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {

  static int? userId;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _dobController = TextEditingController();
  final _parentNameController = TextEditingController();
  File? _profileImage;
  String _selectedGender = 'Male';


  // int? userId;

  Future<void> _saveProfile() async {
    if (_validateForm()) {
      final url = 'http://10.0.2.2:8000/babyapp/childcreate/'; 

      final requestData = {
        'first_name': _firstnameController.text,
        'last_name': _lastnameController.text,
        'date_of_birth': _dobController.text,
        'sex': _selectedGender,
        'parent_username': _parentNameController.text,
      };

      try {
        final response = await http.post(
          Uri.parse(url),
          body: json.encode(requestData),
          headers: {
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 201) {
          print(response.body);
          _showSnackBar('Profile created successfully!');
          final Map<String, dynamic> responseData = json.decode(response.body);
          
          // userId = responseData['id']; 
          ProfilePage.userId = responseData["id"];

        print('Retrieved ID: ${ProfilePage.userId}');
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => VaccineCalendar()));
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => BottomNavi()));
        } else {
          _showSnackBar('Failed to create profile. Please try again.');
        }
      } catch (e) {
        print('Exception: $e');
        _showSnackBar('Failed to create profile. Please try again.');
      }
    }
  }

  bool _validateForm() {
    if (_firstnameController.text.isEmpty ||  
        _lastnameController.text.isEmpty || 
        _dobController.text.isEmpty ||
        _parentNameController.text.isEmpty ||
        _selectedGender.isEmpty) {
      _showSnackBar('Please fill in all fields.');
      return false;
    }
    return true;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

   Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dobController.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 50,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!) as ImageProvider<Object>?
                          : AssetImage("assets/profile.jpeg"),
                          
                    ),
                  ),
                ),
                SizedBox(height: 50),

                TextFormField(
                  controller: _firstnameController,
                  decoration: InputDecoration(labelText: 'First Name',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(borderRadius: BorderRadius
                        .circular(30) ),),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _lastnameController,
                  decoration: InputDecoration(labelText: 'Last Name',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(borderRadius: BorderRadius
                        .circular(30) ),),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _dobController,
                  decoration: InputDecoration(labelText: 'Date of Birth',  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(borderRadius: BorderRadius
                        .circular(30) ),),
                  onTap: () => _selectDate(context),
                  readOnly: true,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _parentNameController,
                  decoration: InputDecoration(labelText: 'Parent Name',  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(borderRadius: BorderRadius
                        .circular(30) ),),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the parent name.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),

                Text("Gender", style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Radio(
                      value: 'Male',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value.toString();
                        });
                      },
                    ),
                    Text('Male'),
                    Radio(
                      value: 'Female',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value.toString();
                        });
                      },
                    ),
                    Text('Female'),
                  ],
                ),


                SizedBox(height: 25),

                Center(
                  child: GestureDetector(
                    onTap: _saveProfile,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Create profile",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue,
                      ),
                    ),
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
  runApp(MaterialApp(
    home: ProfilePage(),
  ));
}
