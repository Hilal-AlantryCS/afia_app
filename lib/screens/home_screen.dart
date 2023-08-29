// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, must_be_immutable, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../components/linkapi.dart';
import '../main.dart';
import '/models/Appcolors.dart';

import '../widgets/doctors_section.dart';
import './myDrawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List imgs = [
    "doctor1.jpeg",
    "doctor2.jpg",
    "doctor3.jpg",
    "doctor4.jpg",
    "doctor1.jpeg",
    "doctor2.jpg",
    "doctor3.jpg",
    "doctor4.jpg",
  ];

  int special = 9;

  List catName = [
    "Cardiology",
    "Ophthalmology",
    "Gastroenterology",
    "Neurology",
    "Gynecology",
    "Orthopedies",
    "Pediatrics",
    "Psychiatry",
    "general medical services",
  ];

  List catImage = [
    "assets/image/sp1.jpg",
    "assets/image/sp2.jpg",
    "assets/image/sp3.jpg",
    "assets/image/sp4.jpg",
    "assets/image/sp5.jpg",
    "assets/image/sp6.jpg",
    "assets/image/sp7.jpg",
    "assets/image/sp8.jpg",
    "assets/image/sp9.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            backgroundColor: lon1,
            leadingWidth: 30,
            title: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage:
                        NetworkImage("$linkPhoto${pref!.getString("photo")}"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "${pref!.getString("first_name")} ${pref!.getString("last_name")}",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Specialization",
                  style: TextStyle(
                    color: bColor.withOpacity(0.7),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                height: 125,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: catName.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            special = index + 1;
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: lon1,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: sdColor,
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundImage:
                                      AssetImage("${catImage[index]}"),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              catName[index],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: bColor.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              // SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 15, bottom: 8),
                child: Text(
                  catName[special - 1],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: bColor.withOpacity(0.7),
                  ),
                ),
              ),
              DoctorsSection(
                sp_id: special,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
