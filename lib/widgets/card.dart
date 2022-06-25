import 'package:flutter/material.dart';
import '/config/size.dart';

class BankCard extends StatelessWidget {
  final String? str;
  BankCard({required this.str});
  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);
    double fontSize(double size) {
      return size * width / 414;
    }

    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: width / 20, vertical: height / 20),
      // child: Stack(
      //   children: <Widget>[
      // Align(
      //   alignment: Alignment.topLeft,
      //   child: Container(
      //       alignment: Alignment.topLeft,
      //       width: width / 1.8,
      //       child: Image.asset(
      //         "assets/mastercardlogo.png",
      //         fit: BoxFit.fill,
      //       )),
      // ),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: height / 10,
            width: width / 1.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  str.toString(),
                  style: TextStyle(
                      fontSize: fontSize(30), fontWeight: FontWeight.w500),
                ),
                // Text(
                //   "1930",
                //   style: TextStyle(
                //       fontSize: fontSize(30),
                //       fontWeight: FontWeight.w500),
                // )

                // Text(
                //   "Platinum Card".toUpperCase(),
                //   style: TextStyle(
                //       fontSize: fontSize(15), fontWeight: FontWeight.bold),
                // )
              ],
            ),
          )),
      // Align(
      //   alignment: Alignment.bottomRight,
      //   child: Container(
      //     alignment: Alignment.bottomRight,
      //     width: width / 6,
      //     height: height / 16,
      //     decoration: BoxDecoration(
      //         color: AppColors.primaryWhite,
      //         boxShadow: AppColors.neumorpShadow,
      //         borderRadius: BorderRadius.circular(20)),
      //   ),
      // ),
      // ],
      // ),
    );
  }
}
