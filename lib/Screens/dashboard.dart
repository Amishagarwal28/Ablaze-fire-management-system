import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/fetch.dart';
import '../config/colors.dart';
import '../config/size.dart';
import '../widgets/appbar.dart';
import '../widgets/cardwidget.dart';
import '../widgets/expenseswidget.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void didChangeDependencies() {
    Provider.of<fetch>(context).fetchTemp;
    Provider.of<fetch>(context).fetchShortCircuit();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);
    num? temp = Provider.of<fetch>(context).temperature;
    final bool? resCircuit = Provider.of<fetch>(context).shortCircuit;

    String resShock() {
      if (resCircuit == false)
        return "No Short Circuit";
      else
        return "Short Circuit";
    }

    return Scaffold(
      body: Container(
        color: AppColors.primaryWhite,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                height: height / 8,
                child: CustomAppBar(),
              ),
              Expanded(
                  child: ExpensesWidget(
                temp: temp,
              )),
              // Expanded(
              //   child: CardWidget(
              //     str1: "Temperature 30°C",
              //   ),
              // ),
              Expanded(
                child: CardWidget(
                  str1: resShock(),
                ),
              ),
              Expanded(
                child:
                    CardWidget(str1: temp == null ? "NO FIRE" : resFire(temp)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String resFire(num value) {
    if (value > 50)
      return "Fire Detected";
    else
      return "No Fire Detected";
  }
}
