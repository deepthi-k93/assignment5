// ignore_for_file: use_build_context_synchronously

import 'package:assignment_5/home_screen.dart';
import 'package:assignment_5/register_acc.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  final String title = "Login Page";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String pwd = '';
  // final storage = FlutterSecureStorage();


  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    //  final ButtonStyle style = ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Email address",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        email = value!;
                      },
                    ),

                    SizedBox(height: 10),

                    TextFormField(
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        pwd = value!;
                      },

                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                      ),
                      obscureText: true,
                      key: Key('password'),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    width: double.maxFinite, // Set the desired width
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          String msg = "";
                          // To write data
                          bool pr = prefs.containsKey(email);
                          if (pr) {
                            msg = "Logged In ";
                            // To write data
                            await prefs.setBool("loggedIn", true);
                            await prefs.setString("loggedInUser",email);
                            String? em = prefs.getString("loggedInUser").toString();
                           /* ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "$msg , ${em!}",
                                  softWrap: true,
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            );*/
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreenPage(loggedUser: em),
                              ),
                            );
                          } else {
                            msg = "User not present";
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  msg,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            );
                          }
                          // To read data
                        }
                      },
                      child: Text(
                        "  Login  ",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.maxFinite, // Set the desired width
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RegisterPage(title: "Register Page"),
                          ),
                        );
                      },
                      child: Text(
                        "  Create Account  ",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
