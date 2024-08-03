import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../global.dart';
import '../screens/home_notes.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();//define username variable
  final TextEditingController _passwordController = TextEditingController();//define password variable
  bool _loading = false;

  void update(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    setState(() {
      _loading = false;
    });
  }
//for login:
  Future<void> _fetchUserData(Function update) async {
    print('${User.id},${User.username}');
    setState(() {
      _loading = true; // Start loading
    });

    final response = await http.post(
      Uri.parse('http://mobilenoteproject.atwebpages.com/login.php'),
      headers: {'Content-Type': 'application/json'},
      body: convert.jsonEncode(<String, String>{
        'username': _usernameController.text.toString(),
        'password': _passwordController.text.toString(),
      }),
    );

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      if (data['status'] == 'success') {
        // Save user ID and username in global variable
        User.id = data['user']['id'].toString();
        User.username = data['user']['username'];
        print('${User.id},${User.username}');
        // Navigate to NotesHome
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NotesHome()),
        );
      } else {
        update(data['message']);
      }
    } else {
      update('Failed to log in. Please try again.');
    }

    setState(() {
      _loading = false; // Stop loading
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),//to make it at the center of the page
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,//to make it at the center of the column

            children: <Widget>[ //to use many widgets like making array of widgets


              // -----put the lock icon and give it a size and color-----
              //---------------------------------------Lock Icon-----------------------------------------
              Icon(
                Icons.lock,
                size: 80.0,
                color: tdBlue,
              ),

              SizedBox(height: 20),

              //---------------display the message welcome back and give it size and color----------------
              Text(
                "Welcome back you've been missed!",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),

              SizedBox(height: 20),


              //-----------------------------------------------------------form

              Form(
                key: _formKey,
                child: Column(
                  children: [
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
                    // ---------------------------------------------Submit button
                    ElevatedButton(
                      onPressed: _loading ? null : () { // disable button while loading
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _loading = true;
                          });
                          _fetchUserData(update);
                          //Funtion to be done upon submisstion or use onsubmit func above
                          //saveCustomer(update, int.parse(_controllerID.text.toString()), _controllerName.text.toString(), double.parse(_controllerBalance.text));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tdBlue,
                        //--to make space between the button and the word inside it--
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                      child: Text(
                        'Sign In',//text inside the button
                        style: TextStyle(color: Colors.white),//set the color to white
                      ),
                    ),

                    Visibility(visible: _loading, child: const CircularProgressIndicator())
                  ],
                ),
              ),
              // End of Form // <-- Note added here


              SizedBox(height: 30),
//-----------------------------------------------If no account-----------------------------------------
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text("Don't have an account?"),
                    SizedBox(width: 10),

                    //--GestureDetector is used to to wrap the text widgets and handle the onTap events to navigate to the respective pages---
                    GestureDetector(
                      onTap: () {
                        //---the register is defined in the main page it will take me to the register page--
                        Navigator.pushNamed(context, '/register');
                      },
                      //--type the text register and set its color and weight--
                      child: Text(
                        "Register",
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
//---
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

