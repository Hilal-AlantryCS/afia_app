// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors, unused_local_variable, unused_element

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/crud.dart';
import '../components/linkapi.dart';
import '../main.dart';
import '../widgets/navbar_roots.dart';
import '../models/Appcolors.dart';
import '../utils.dart';
// import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _validate = false;
  TextEditingController emailControllar = TextEditingController();
  TextEditingController passwordControllar = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw Exception('Could not launch $url');
    }
  }

  bool passToggle = true;

  Crud crud = new Crud();

  bool isLoading = false;

  login() async {
    if (_formKey.currentState!.validate()) {
      // setState(() {
      //   isLoading = true;
      // });
      var response = await crud.postRequest(linkLogin, {
        "email": emailControllar.text,
        "password": passwordControllar.text,
      });
      if (response == null) {
        AwesomeDialog(
          context: context,
          title: "Warning",
          body: Container(
            padding: EdgeInsets.all(15),
            child: Text(
              "There is no account with this email or password is wrong",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: lon2,
              ),
            ),
          ),
        )..show();
        return;
      }
      if (response["error_field"] == null && response["data"] != null) {
        pref!.setString("id", response['data']['user']['id'].toString());
        pref!.setString("first_name", response['data']['user']['first_name']);
        pref!.setString("last_name", response['data']['user']['last_name']);
        pref!.setString("email", response['data']['user']['email']);

        pref!.setString(
            "phone_number", response['data']['user']['phone_number']);
        pref!.setString("birth_date", response['data']['user']['birth_date']);
        pref!.setString(
            "chronic_disease", response['data']['user']['chronic_disease']);
        pref!.setString(
            "genetic_disease", response['data']['user']['genetic_disease']);

        pref!.setString("photo", response['data']['user']['photo']);
        pref!.setInt("role", response['data']['user']['role']);
        if (response['data']['user']['gender'] == 0) {
          pref!.setString("gender", "male");
        } else {
          pref!.setString("gender", "female");
        }
        pref!.setInt("length", response['data']['user']['length']);
        pref!.setInt("weight", response['data']['user']['weight']);
        pref!.setInt("city_id", response['data']['user']['city']['id']);
        pref!.setString("city_name", response['data']['user']['city']['name']);
        pref!.setString("country", response['data']['user']['city']['country']);
        pref!.setString("access", response['data']['access']);
        Get.to(NavBarRoots());
      } else if (response != null) {
        AwesomeDialog(
          context: context,
          title: "Warning",
          btnCancel: Text("Cancel"),
          body: Text(
            response['message'],
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: lon2,
            ),
          ),
        )..show();
      } else {
        AwesomeDialog(
          context: context,
          title: "Warning",
          body: Container(
            padding: EdgeInsets.all(15),
            child: Text(
              "There is no account with this email",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: lon2,
              ),
            ),
          ),
        )..show();
      }
      // setState(() {
      //   isLoading = false;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Uri toLaunch = Uri(
        scheme: 'http', host: '154.62.109.112', port: 3001, path: 'Register');
    return Material(
      color: lon4,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
              width: size.width,
              height: size.height * 1.5,
              child: Column(
                children: [
                  Container(
                    // height: size.height * 0.4,
                    child: Stack(
                      children: [
                        Container(
                          child: ClipPath(
                            child: Container(
                              width: size.width,
                              height: size.height * 0.25,
                              color: lon2,
                            ),
                            clipper: CustomClipPath1(),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SvgPicture.asset("assets/image/Logo.svg"),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // verticalDirection: VerticalDirection.up,
                            children: [
                              SizedBox(height: 280),
                              Text(
                                "Afia App",
                                style: TextStyle(
                                  color: lon3,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.1,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                  wordSpacing: 2,
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.008),
                              Text(
                                "Appoint Your Doctor",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: size.height * 0.0125),
                  // Padding(
                  //   padding: EdgeInsets.all(size.height * 0.025),
                  //   child: Image.asset("assets/image/doctors2.jpg"),
                  // ),

                  // SizedBox(height: size.height * 0.0125),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.height * 0.0145),
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
                    padding: EdgeInsets.all(size.height * 0.0145),
                    child: TextFormField(
                      validator: (value) {
                        return value!.isEmpty ? 'please cheack password' : null;
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
                  SizedBox(height: size.height * 0.025),
                  Padding(
                    padding: EdgeInsets.all(size.height * 0.0125),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: lon2,
                        backgroundColor: lon2,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          login();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.017,
                            horizontal: size.width * 0.2),
                        child: Center(
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              fontSize: size.height * 0.04,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have any account?",
                        style: TextStyle(
                          fontSize: size.height * 0.022,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _launchInWebViewOrVC(toLaunch);
                          });
                        },
                        child: Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: size.height * 0.022,
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

class CustomClipPath extends CustomClipper<Path> {
  var radius = 8.0;
  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(0, size.height);
    path0.quadraticBezierTo(0, size.height * 0.2500000, 0, 0);
    path0.cubicTo(size.width * 0.0633250, size.height * 0.9610000,
        size.width * 0.9392125, size.height * 0.9731000, size.width, 0);
    path0.quadraticBezierTo(
        size.width, size.height * 0.2500000, size.width, size.height);
    path0.lineTo(0, size.height);
    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
