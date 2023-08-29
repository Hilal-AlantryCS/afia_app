import 'package:flutter/material.dart';

import '../models/Appcolors.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
        backgroundColor: lon1,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              "Services",
              style: TextStyle(
                fontSize: 30,
                color: lon2,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  Icons.date_range_outlined,
                  size: 50,
                  color: lon3,
                ),
                SizedBox(width: 15),
                Text(
                  "Dating",
                  style: TextStyle(
                    fontSize: 30,
                    color: lon3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "This service involves providing advice and guidance to individuals regarding their health concerns. This can be done through one-on-one sessions with a healthcare professional.",
              style: TextStyle(
                wordSpacing: 6,
                color: lon1,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
