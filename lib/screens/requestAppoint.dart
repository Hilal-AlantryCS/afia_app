// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, unused_local_variable
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:aafia/components/linkapi.dart';

import '../components/crud.dart';
import '../main.dart';
import '../models/Appcolors.dart';

class RequestAppoint extends StatefulWidget {
  String lastDate;
  String idate;
  RequestAppoint({
    Key? key,
    required this.lastDate,
    required this.idate,
  }) : super(key: key);

  @override
  State<RequestAppoint> createState() => _RequestAppointState();
}

class _RequestAppointState extends State<RequestAppoint> with Crud {
  TextEditingController note = TextEditingController();

  DateTime dt = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 20),
          child: Column(
            children: [
              SizedBox(height: 25),
              Row(
                children: [
                  Icon(
                    Icons.date_range_outlined,
                    size: 40,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Last Date : ",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: bColor,
                    ),
                  ),
                  Text(
                    "${widget.lastDate}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: lon1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Icon(
                    Icons.date_range_outlined,
                    size: 40,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "New Date : ",
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
              SizedBox(height: 15),
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
              SizedBox(height: 25),
              Container(
                padding: EdgeInsets.all(15),
                height: 90,
                decoration: BoxDecoration(
                  color: lon3,
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
                    var response = await putReq(
                      "$linkRequestAppointment${widget.idate}/",
                      "${pref!.getString("access")}",
                      {
                        "date": "${dt.year}-${dt.month}-${dt.day}",
                        "patient_notes": note.text,
                      },
                    );
                    if (response == null) {
                      AwesomeDialog(
                        context: context,
                        title: "Warning",
                        body: Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "Your Appointment Updated Successfully.",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: lon1,
                            ),
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
                            "Your Appointment Updated Successfully.",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: lon1,
                            ),
                          ),
                        ),
                      )..show();
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      color: lon1,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Request Appointment",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
