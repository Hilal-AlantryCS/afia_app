// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, deprecated_member_use, unused_field, unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/linkapi.dart';
import '../main.dart';
import '../models/Appcolors.dart';
import 'aboutus.dart';
import 'profile.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String _phone = '0932572553';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            color: lon4,
            child: CircleAvatar(
              radius: 45,
              backgroundImage:
                  NetworkImage("$linkPhoto${pref!.getString("photo")}"),
            ),
          ),
          Text(
            "${pref!.getString("first_name")} ${pref!.getString("last_name")}",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: lon1,
            ),
          ),
          SizedBox(height: 20),
          buildListTile(
            "Profile",
            Icons.home_rounded,
            () {
              Get.to(Profile());
            },
          ),
          buildListTile(
            "Call Us",
            Icons.phone,
            () {
              launchUrl(Uri(
                scheme: 'tel',
                path: _phone,
              ));
            },
          ),
          buildListTile(
            "About Us",
            Icons.info_outline_rounded,
            () {
              Get.to(AboutUs());
            },
          ),
        ],
      ),
    );
  }

  ListTile buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontFamily: "RobotoCondensed",
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () => tapHandler(),
    );
  }
}
