// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/Appcolors.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    final Uri toLaunch = Uri(
        scheme: 'http', host: '154.62.109.112', port: 3001, path: 'Register');
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.035),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Stack(
                children: [
                  Container(
                    child: ClipPath(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.20,
                        color: lon2,
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
            Text(
              "Afia App",
              style: TextStyle(
                color: lon3,
                fontSize: MediaQuery.of(context).size.width * 0.1,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                wordSpacing: 2,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              "Appoint Your Doctor",
              style: TextStyle(
                color: Colors.black54,
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: lon3,
                    backgroundColor: lon2,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  onPressed: () {
                    Get.to(LoginScreen());
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.width * 0.05,
                      horizontal: MediaQuery.of(context).size.height * 0.05,
                    ),
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.055,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: lon4,
                    backgroundColor: lon3,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                  onPressed: () {
                    // !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                    setState(() {
                      _launchInWebViewOrVC(toLaunch);
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.width * 0.05,
                      horizontal: MediaQuery.of(context).size.height * 0.05,
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
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
