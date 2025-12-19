import 'dart:convert';

import 'package:assignment_5/model/user_model.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.title});
  final String title;
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String cusName = '';
  String email = '';
  String pwd = '';
  String cnfrmPwd = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: .center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Name",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter customer name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        cusName = value!;
                      },
                    ),

                    SizedBox(height: 10),

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
                      onChanged: (value) {
                        pwd = value;
                        setState(() {});
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

                    SizedBox(height: 10),

                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                      ),
                      obscureText: true,

                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Password is required';
                        } else if (value.trim() != pwd) {
                          return 'Passwords must be same';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        cnfrmPwd = newValue!;
                      },
                    ),
                  ],
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  String msg = "Registered Successfully ";

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
                  Navigator.pop(context);
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  UserModel user = UserModel(
                    userName: cusName,
                    userEmail: email,
                    password: pwd,
                  );

                  String userJson = jsonEncode(user.toJson());
                  await prefs.setString(
                    email,
                    userJson,
                  ); // Save the JSON string in SharedPreferences

                  String? user1 = prefs.getString(email);
                  if (user1 == null) {
                    return;
                  }
                  Map<String, dynamic> userMap =
                      jsonDecode(user1) as Map<String, dynamic>;

                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "email :${UserModel.fromJson(userMap).userEmail}",
                        softWrap: true,
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  );

                  /*
                 final storage = FlutterSecureStorage();
                  await storage.write(key: email, value: pwd);

                  // To read data
                  String? password = await storage.read(key: email);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "email :$password!",
                        softWrap: true,
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  );*/
                }
              },
              child: Text(
                "  Register  ",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      /* floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),*/
    );
  }
}
