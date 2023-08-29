import 'package:aafia/screens/requestAppoint.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'models/Appcolors.dart';
import 'welcomescreens/doctor_up.dart';
import 'welcomescreens/login_screen.dart';
import 'welcomescreens/signup_screen.dart';
import 'welcomescreens/user_up.dart';
import 'widgets/navbar_roots.dart';
import 'welcomescreens/welcome_screen.dart';

SharedPreferences? pref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  pref = await SharedPreferences.getInstance();
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: lon1,
        canvasColor: lon4,
      ),
      initialRoute: pref!.getString("id") == null ? "/welcome" : "navbarroot",
      // initialRoute: "/requestappointment",
      getPages: [
        GetPage(name: "/welcome", page: () => WelcomeScreen()),
        GetPage(name: "/signup", page: () => SignUpScreen()),
        GetPage(name: "/login", page: () => LoginScreen()),
        GetPage(name: "/doctorup", page: () => DoctorUP()),
        GetPage(name: "/userup", page: () => UserUP()),
        GetPage(name: "/navbarroot", page: () => NavBarRoots()),
      ],
    );
  }
}
