// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/linkapi.dart';
import '../main.dart';
import '../welcomescreens/welcome_screen.dart';
import 'aboutus.dart';
import 'profile.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Settings",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 30),
            InkWell(
              onTap: () {
                Get.to(Profile());
              },
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage("$linkPhoto${pref!.getString("photo")}"),
                ),
                title: Text(
                  "${pref!.getString("first_name")} ${pref!.getString("last_name")}",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text("Profile"),
              ),
            ),
            Divider(height: 50),
            listSettings(
              "Profile",
              CupertinoIcons.person,
              Colors.blue,
              Colors.blue.shade100,
              () {
                Get.to(Profile());
              },
            ),
            SizedBox(height: 20),
            listSettings(
              "Notification",
              Icons.notifications_none_outlined,
              Colors.deepPurple,
              Colors.deepPurple.shade100,
              () {},
            ),
            SizedBox(height: 20),
            listSettings(
              "Privacy",
              Icons.privacy_tip_outlined,
              Colors.indigo,
              Colors.indigo.shade100,
              () {},
            ),
            SizedBox(height: 20),
            listSettings(
              "General",
              Icons.settings_suggest_outlined,
              Colors.green,
              Colors.green.shade100,
              () {},
            ),
            SizedBox(height: 20),
            listSettings(
              "About Us",
              Icons.info_outline_rounded,
              Colors.orange,
              Colors.orange.shade100,
              () {
                Get.to(AboutUs());
              },
            ),
            Divider(height: 35),
            listSettings(
              "Log Out",
              Icons.logout,
              Colors.redAccent,
              Colors.redAccent.shade100,
              () {
                pref!.clear();
                Get.offAll(WelcomeScreen());
              },
            ),
          ],
        ),
      ),
    );
  }

  ListTile listSettings(String str, IconData icony, Color colour,
      Color colorshade, Function() param3) {
    return ListTile(
      onTap: param3,
      leading: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colorshade,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icony,
          color: colour,
          size: 35,
        ),
      ),
      title: Text(
        str,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}
