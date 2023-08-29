// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, unused_element, unused_local_variable
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../components/crud.dart';
import '../components/linkapi.dart';
import '../main.dart';
import '../models/Appcolors.dart';

class AppointScreen extends StatefulWidget with Crud {
  int sp_id;
  int spindex;
  AppointScreen({
    Key? key,
    required this.sp_id,
    required this.spindex,
  }) : super(key: key);

  @override
  State<AppointScreen> createState() => _AppointScreenState();
}

class _AppointScreenState extends State<AppointScreen> {
  var doctorProfile;
  get sp_id => widget.sp_id;
  get spindex => widget.spindex;

  TextEditingController note = TextEditingController();
  DateTime dt = DateTime.now();
  late String doctor_id;

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

  getDoctorProfile() async {
    var response = await widget.getReq(
        "$linkGetDoctors${sp_id}", "${pref!.getString("access")}");
    var a = response['data']
        .toList()
        .where((e) => "${e['available_for_meeting']}" == "true");
    a = a.toList();
    return a[spindex];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: FutureBuilder(
        future: getDoctorProfile(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['error_field'] != null) {
              return Center(
                  child: Text(
                "No doctors with this specialization",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ));
            } else {
              doctor_id = "${snapshot.data['id']}";
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                      height: size.height / 3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("${snapshot.data['photo']}"),
                          fit: BoxFit.contain,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              pColor.withOpacity(0.9),
                              pColor.withOpacity(0),
                              pColor.withOpacity(0),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 30, left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(8),
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF2F8FF),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: sdColor,
                                            blurRadius: 4,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.arrow_back,
                                          color: pColor,
                                          size: 28,
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
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${snapshot.data['first_name']} ${snapshot.data['last_name']}",
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w500,
                              color: pColor,
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundImage: AssetImage(catImage[
                                    snapshot.data['specialization']['id'] - 1]),
                              ),
                              SizedBox(width: 10),
                              Text(
                                catName[
                                    snapshot.data['specialization']['id'] - 1],
                                style: TextStyle(
                                  fontSize: 25,
                                  color: lon2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 40,
                                color: lon3,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "${snapshot.data['city']['country']} : ${snapshot.data['city']['name']}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: lon2,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Text(
                            "${snapshot.data['experience']}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: lon2.withOpacity(1),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Icon(
                                Icons.date_range_outlined,
                                size: 40,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Book Date : ",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: bColor,
                                ),
                              ),
                              Text(
                                "${dt.year}-${dt.month}-${dt.day}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: lon1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          InkWell(
                            //todo>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2025),
                              ).then((value) {
                                if (value == null) {
                                } else {
                                  setState(() {
                                    dt = value;
                                  });
                                }
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(vertical: 18),
                              margin: EdgeInsets.symmetric(horizontal: 25),
                              decoration: BoxDecoration(
                                color: lon2,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Choose Your Date",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.note,
                                size: 40,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Note : ",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: bColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            maxLines: 4,
                            controller: note,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Align(
                                alignment: Alignment.topCenter,
                                child: Text("Enter Your Note"),
                              ),
                            ),
                          ),
                          SizedBox(height: 150),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15),
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: InkWell(
          //todo>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
          onTap: () async {
            var response = await widget.postReq(
              "$linkPostAppointment",
              "${pref!.getString("access")}",
              {
                "date": "${dt.year}-${dt.month}-${dt.day}",
                "doctor_id": doctor_id,
                "patient_notes": note.text,
              },
            );
            AwesomeDialog(
              context: context,
              title: "Warning",
              body: Container(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Your Book Created Successfully.",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: lon1,
                  ),
                ),
              ),
            )..show();
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              color: lon2,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                "Book Appointment",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
