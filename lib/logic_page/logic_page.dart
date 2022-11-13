// import 'package:bask_fl_2/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../components/menu.dart';

class LogicScreen extends StatefulWidget {
  @override
  _LogicScreenState createState() => _LogicScreenState();
}

class _LogicScreenState extends State<LogicScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance
        .addPostFrameCallback((_) => _determineFirstPage(context));
  }

  void _determineFirstPage(context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MenuTabs()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(48.0),
          child: Text("Nothing to show here..."),
        ),
      ),
    );
  }
}
