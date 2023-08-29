import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../components/linkapi.dart';
import '../components/crud.dart';
import '../main.dart';
import '../models/Appcolors.dart';
import '../utils.dart';
import 'doctor_up.dart';
import 'login_screen.dart';
import 'user_up.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  int? _isdoctor = 1;
  bool passToggle = true;
  bool _validate = false;
  TextEditingController firstnameControllar = TextEditingController();
  TextEditingController lastnameControllar = TextEditingController();
  TextEditingController emailControllar = TextEditingController();
  TextEditingController passwordControllar = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;
  Crud _crud = Crud();

  signUp() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      var response = await _crud.postRequest(linkSignUp, {
        "role": _isdoctor,
        "first_name": firstnameControllar.text,
        "last_name": lastnameControllar.text,
        "email": emailControllar.text,
        "password": passwordControllar.text,
      });

      if (response['error_field'] == null) {
        pref!.setString("id", response["data"]["user"]["id"]);
        pref!.setString("email", response["data"]["user"]["email"]);
        pref!.setString("password", response["data"]["user"]["password"]);
        pref!.setString("first_name", response["data"]["user"]["first_name"]);
        pref!.setString("last_name", response["data"]["user"]["last_name"]);
        pref!.setInt("role", response["data"]["user"]["role"]);
      } else {
        AwesomeDialog(
          context: context,
          btnCancel: Text("Cancel"),
          title: "Warning",
          body: Text("SignUp Fail"),
        )..show();
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      child: SingleChildScrollView(
        child: Container(
          height: size.height * 1.25,
          width: double.infinity,
          color: lon4,
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  height: size.height * 0.4,
                  child: Stack(
                    children: [
                      Container(
                        child: ClipPath(
                          child: Container(
                            width: size.width,
                            height: size.height * 0.20,
                            color: lon3,
                          ),
                          clipper: CustomClipPath1(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SvgPicture.asset("assets/image/Logo.svg"),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Radio(
                            value: 1,
                            groupValue: _isdoctor,
                            onChanged: (value) {
                              setState(() {
                                _isdoctor = value;
                              });
                            },
                          ),
                          Text(
                            "Patient",
                            style: TextStyle(
                              fontSize: 25,
                              color: _isdoctor == 1 ? lon1 : Colors.grey,
                            ),
                          ),
                          Radio(
                            value: 0,
                            groupValue: _isdoctor,
                            onChanged: (value) {
                              setState(() {
                                _isdoctor = value;
                              });
                            },
                          ),
                          Text(
                            "Doctor",
                            style: TextStyle(
                              fontSize: 25,
                              color: _isdoctor == 0 ? lon1 : Colors.grey,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.01,
                          horizontal: size.width * 0.035,
                        ),
                        child: TextFormField(
                          validator: (value) {
                            return value!.isEmpty
                                ? 'please put your name'
                                : null;
                          },
                          controller: firstnameControllar,
                          decoration: InputDecoration(
                            labelText: "First Name",
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
                            return value!.isEmpty
                                ? 'please put your name'
                                : null;
                          },
                          controller: lastnameControllar,
                          decoration: InputDecoration(
                            labelText: "Last Name",
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
                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //     vertical: size.height * 0.01,
                      //     horizontal: size.width * 0.035,
                      //   ),
                      //   child: TextFormField(
                      //     decoration: InputDecoration(
                      //       labelText: "Phone Number",
                      //       border: OutlineInputBorder(),
                      //       prefixIcon: Icon(Icons.phone),
                      //     ),
                      //   ),
                      // ),
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
                              backgroundColor: lon3,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                //todo>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                if (_isdoctor == 0) {
                                  Get.to(UserUP());
                                } else {
                                  Get.to(DoctorUP());
                                }
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
                                    color: Colors.white,
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
                      ),
                    ],
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

class CustomClipPath1 extends CustomClipper<Path> {
  var radius = 8.0;
  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(size.width * 0.0083500, size.height * 0.0004527);
    path0.lineTo(size.width, 0);
    path0.quadraticBezierTo(size.width * 1.0292750, size.height * 0.9169822,
        size.width * 0.8792750, size.height * 0.8189300);
    path0.cubicTo(
        size.width * 0.7968500,
        size.height * 0.7568176,
        size.width * 0.7840750,
        size.height * 0.3868724,
        size.width * 0.4896500,
        size.height * 0.3755144);
    path0.cubicTo(
        size.width * 0.2269750,
        size.height * 0.3929630,
        size.width * 0.1951750,
        size.height * 0.7604801,
        size.width * 0.1208250,
        size.height * 0.8232373);
    path0.quadraticBezierTo(size.width * -0.0609500, size.height * 0.8933196,
        size.width * 0.0083500, size.height * 0.0004527);
    path0.close();
    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
