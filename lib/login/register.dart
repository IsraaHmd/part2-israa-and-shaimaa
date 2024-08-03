import 'package:flutter/material.dart';
import '../constants/colors.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../global.dart';
import '../screens/home_notes.dart'; // Add this import

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> registerKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _loading = false;
  void update(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    setState(() {
      _loading = false;
    });
  }
  Future<void> _registerUser(String username, String password, String confirmPassword) async {
    User.id = '';
    User.username = '';

    print('${User.id},${User.username}');

    final response = await http.post(
      Uri.parse('http://mobilenoteproject.atwebpages.com/register.php'),
      body: convert.jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'confirmPassword': confirmPassword,
      }),
      // headers: {"Content-Type": "application/json"},
    ).timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      if (data['status'] == 'success') {
        // Save user ID and username in global variable
        User.id = data['user']['id'].toString();
        User.username = data['user']['username'];
        print('${User.id},${User.username}');
        // Navigate to NotesHome on successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NotesHome()),
        );
      } else {
        update(data['message']); // Display any error messages returned by the PHP script
      }
    } else {
      update("Server error"); // Handle server errors
    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              //---------------------------------------Lock Icon---------------------------------------------
              Icon(
                Icons.lock,
                size: 80.0,
                color: tdBlue,
              ),
              SizedBox(height: 20),

              Text(
                "Let's create an account for you!",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),

              SizedBox(height: 20),
              //-------------------------------------------------Form
              Form(
                key: registerKey,
                child: Column(
                  children: [
                    // -------------------------------------username textfield--------------------------------------------
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                        filled: true,
                        fillColor: tdBGColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    //------------------------------------password textfield--------------------------------------------
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        filled: true,
                        fillColor: tdBGColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    //-----------------------------------confirm password text field-----------------------------------
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                        filled: true,
                        fillColor: tdBGColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 30),

                    //---------------------------------Sign up Elevated button---------------------------------
                    ElevatedButton(
                      onPressed:  _loading ? null :() {
                        if (registerKey.currentState!.validate()) {
                          setState(() {
                            _loading = true;
                          });
                          //  sign up logic here
                          _registerUser(
                            _usernameController.text.toString(),
                            _passwordController.text.toString(),
                            _confirmPasswordController.text.toString(), // confirmPassword
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tdBlue,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Visibility(visible: _loading, child: const CircularProgressIndicator()),
                    SizedBox(height: 30),
                  ],
                ),
              ),
                    // --------------------------------------------------------End of Form

              //-------------------------------If account exist-----------------------------
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text("Already have an account?"),
                    SizedBox(width: 10),

                    //-------------------------GestureDetector---------------------------
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )

                  ])
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
