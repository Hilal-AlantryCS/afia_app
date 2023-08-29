// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../models/Appcolors.dart';
import '../utils.dart';
import '../widgets/my_header.dart';
import 'login_screen.dart';

class UserUP extends StatefulWidget {
  const UserUP({Key? key}) : super(key: key);

  @override
  State<UserUP> createState() => _UserUP();
}

class _UserUP extends State<UserUP> {
  bool passToggle = true;
  bool _validate = false;
  TextEditingController usernameControllar = TextEditingController();
  TextEditingController emailControllar = TextEditingController();
  TextEditingController passwordControllar = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.01,
                      horizontal: size.width * 0.035,
                    ),
                    child: TextFormField(
                      validator: (value) {
                        return value!.isEmpty ? 'please put your name' : null;
                      },
                      controller: usernameControllar,
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.01,
                      horizontal: size.width * 0.035,
                    ),
                    child: TextFormField(
                      validator: (value) {
                        return value!.isEmpty || !isEmail(value)
                            ? 'please cheack email'
                            : null;
                      },
                      controller: emailControllar,
                      decoration: InputDecoration(
                        errorText: _validate ? 'value cant be empty' : null,
                        border: OutlineInputBorder(),
                        label: Text("Email Addres"),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.01,
                      horizontal: size.width * 0.035,
                    ),
                    child: TextFormField(
                      validator: (value) {
                        return value!.isEmpty || !isPassword(value)
                            ? 'please cheack password'
                            : null;
                      },
                      controller: passwordControllar,
                      obscureText: passToggle ? true : false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Enter Password"),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: InkWell(
                          onTap: () {
                            passToggle = !passToggle;
                            setState(() {});
                          },
                          child: passToggle
                              ? Icon(CupertinoIcons.eye_slash_fill)
                              : Icon(CupertinoIcons.eye_fill),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.height * 0.0125),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shadowColor: lon2,
                          backgroundColor: lon1,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            //todo>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (ctx) => LoginScreen(),
                            //     ));
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.0185,
                            horizontal: size.width * 0.1,
                          ),
                          child: Center(
                            child: Text(
                              "Create Account",
                              style: TextStyle(
                                fontSize: size.width * 0.055,
                                color: lon4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.0125),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(LoginScreen());
                        },
                        child: Text(
                          "Log In",
                          style: TextStyle(
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: lon1,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
