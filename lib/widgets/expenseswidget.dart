import 'package:fire/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

import '../config/size.dart';
import 'package:provider/provider.dart';
import '../providers/fetch.dart';
// import '/piechart/piechart.dart';

// import 'config/strings.dart';

class ExpensesWidget extends StatefulWidget {
  final num? temp;
  ExpensesWidget({this.temp});
  @override
  _ExpensesWidgetState createState() => _ExpensesWidgetState();
}

class _ExpensesWidgetState extends State<ExpensesWidget> {
  // var data;
  // var _isInit = true;
  // late final DatabaseReference _dbref = FirebaseDatabase.instance.ref();
  double? databasejson;

  Color getColor(number) {
    if (number > 50) {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }

  @override
  void initState() {
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<temp>(context,listen: false).fetchTemp();
    // });
    super.initState();
    //Provider.of<temp>(context).fetchTemp();
  }

  @override
  void didChangeDependencies() {
    Provider.of<fetch>(context).fetchTemp();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //_activateListeners();
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);
    double fontSize(double size) {
      return size * width / 414;
    }

    // final num? temp = Provider.of<fetch>(context).temperature;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // Container(
        //   height: height / 14,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: <Widget>[
        //       Container(
        //           margin: EdgeInsets.only(left: width / 20),
        //           child: Text(
        //             "Monthly Expenses",
        //             style: TextStyle(
        //                 fontWeight: FontWeight.bold, fontSize: fontSize(20)),
        //           )),
        //       Container(
        //         width: width / 3.5,
        //         margin: EdgeInsets.only(right: width / 30),
        //         child: Row(
        //           children: <Widget>[
        //             ArrowButton(
        //               margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        //               icon: Icon(
        //                 Icons.arrow_back_ios,
        //                 size: fontSize(17),
        //               ),
        //             ),
        //             Padding(padding: EdgeInsets.only(left: width / 50)),
        //             ArrowButton(
        //               icon: Icon(
        //                 Icons.arrow_forward_ios,
        //                 size: fontSize(17),
        //               ),
        //             )
        //           ],
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        // Container(
        //     margin: EdgeInsets.symmetric(horizontal: width / 20),
        //     alignment: Alignment.centerLeft,
        //     child: Text(
        //       "About Temp",
        //       style: TextStyle(
        //           fontWeight: FontWeight.bold, fontSize: fontSize(20)),
        //     )),
        Expanded(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    // child: Row(
                    //   children: <Widget>[
                    //     Container(
                    //       margin: EdgeInsets.only(right: 10),
                    //       width: 10,
                    //       height: 10,
                    //       decoration: BoxDecoration(
                    //           color: AppColors
                    //               .pieColors[category.indexOf(data)],
                    //           shape: BoxShape.circle),
                    //     ),
                    child: Text(
                      "Temperature",
                      style: TextStyle(
                        fontSize: fontSize(34),
                      ),
                    ),
                    //   ],
                    // ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(right: 0),
                  // child: Consumer<fetch>(builder: (context, fetchTemp, c) {
                  //   return
                  // Text(
                  //   temp.toString() + " °C",
                  //   style: TextStyle(color: Colors.blueAccent, fontSize: 30),
                  // )
                  child: widget.temp == null
                      ? circularProgress()
                      : Text(
                          widget.temp.toString() + " °C",
                          style: TextStyle(
                              color: getColor(widget.temp), fontSize: 30),
                        ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
