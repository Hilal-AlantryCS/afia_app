// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, unused_local_variable
import '/components/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/crud.dart';
import '../main.dart';
import '../models/Appcolors.dart';
import '../screens/appoint_screen.dart';

class DoctorsSection extends StatelessWidget with Crud {
  int sp_id;
  DoctorsSection({
    Key? key,
    required this.sp_id,
  }) : super(key: key);

  getDoctors() async {
    var response =
        await getReq("$linkGetDoctors$sp_id", "${pref!.getString("access")}");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDoctors(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['error_field'] != null &&
                snapshot.data['data'] == null) {
              return Center(
                  child: Text(
                "No doctors with this specialization",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ));
            } else {
              var a = snapshot.data['data']
                  .toList()
                  .where((e) => "${e['available_for_meeting']}" == "true");
              a = a.toList();
              return Container(
                height: 410,
                // width: 250,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: a.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          // height: 350,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          margin: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          decoration: BoxDecoration(
                            color: Color(0xFFF2F8FF),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: sdColor,
                                blurRadius: 4,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(AppointScreen(
                                    sp_id: sp_id,
                                    spindex: index,
                                  ));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  child: Image.network(
                                    "${a[index]['photo']}",
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${a[index]['first_name']} ${a[index]['last_name']}",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        color: pColor,
                                      ),
                                    ),
                                    Text(
                                      "${a[index]['specialization']['name']}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: bColor.withOpacity(0.6),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "${a[index]['city']['country']} : ${a[index]['city']['name']}",
                                      style: TextStyle(
                                        color: bColor.withOpacity(0.6),
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "${a[index]['experience']}",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        color: lon3,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
              );
            }
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
