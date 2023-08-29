// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:aafia/screens/requestAppoint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/crud.dart';
import '../components/linkapi.dart';
import '../main.dart';
import '../models/Appcolors.dart';

class UpcomingSchedule extends StatefulWidget {
  @override
  State<UpcomingSchedule> createState() => _UpcomingScheduleState();
}

class _UpcomingScheduleState extends State<UpcomingSchedule> with Crud {
  getAppointments() async {
    var response =
        await getReq("$linkGetAppointment", "${pref!.getString("access")}");
    return response;
  }

  String getTime(String t) {
    if (t == "null") {
      return "";
    } else {
      return t;
    }
  }

  String getStatus(int s) {
    if (s == 0) {
      return "requested";
    } else if (s == 1) {
      return "accepted";
    } else if (s == 2) {
      return "rejected";
    } else if (s == 3) {
      return "confirmed";
    }
    return "canceled";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: getAppointments(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['error_field'] != null) {
            return Center(
                child: Text(
              "You don't have an appointment",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ));
          } else if (snapshot.data['data'] != null) {
            var a = snapshot.data['data']['data']
                .toList()
                .where((e) =>
                    (e['status'] == 0 || e['status'] == 1 || e['status'] == 2))
                .toList();
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Appointment",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    child: Container(
                      height: 500,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: a.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              upcomingappointment(
                                context,
                                "${a[index]['doctor']['first_name']} ${a[index]['doctor']['last_name']}",
                                "${a[index]['doctor']['specialization']['name']}",
                                "${a[index]['doctor']['photo']}",
                                "${a[index]['date']}",
                                getTime("${a[index]['time']}"),
                                a[index]['status'],
                                () {
                                  var response = putReq(
                                      "$linkCancelAppointment${a[index]['id']}/",
                                      "${pref!.getString("access")}", {});
                                  setState(() {});
                                },
                                () {
                                  if (a[index]['status'] == 1) {
                                    var response = putReq(
                                        "$linkConfirmAppointment${a[index]['id']}/",
                                        "${pref!.getString("access")}", {});
                                  }
                                  if (a[index]['status'] == 2) {
                                    Get.to(RequestAppoint(
                                      lastDate: "${a[index]['date']}",
                                      idate: "${a[index]['id']}",
                                    ));
                                  }
                                  setState(() {});
                                },
                              ),
                              SizedBox(height: 20)
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                "No Data",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  //?>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  Container upcomingappointment(
    BuildContext context,
    String doctorname,
    String doctorSpacial,
    String imageURL,
    String yeardate,
    String timedate,
    int status,
    void Function()? cancelfunc,
    void Function()? reschedulefunc,
  ) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ListTile(
              title: Text(
                doctorname,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(doctorSpacial),
              trailing: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(imageURL),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                thickness: 1,
                height: 20,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 5),
                    Text(
                      yeardate,
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_filled,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 5),
                    Text(
                      timedate,
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: cancelfunc,
                  child: Container(
                    width: 150,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F6FA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: reschedulefunc,
                  child: Container(
                    width: 150,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: lon1,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        status == 1
                            ? "Confirm"
                            : status == 2
                                ? "Request"
                                : "Wait Doctor Response",
                        style: TextStyle(
                          fontSize: status == 0 ? 12 : 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
