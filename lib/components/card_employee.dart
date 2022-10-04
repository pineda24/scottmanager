import 'dart:ffi';

import 'package:flutter/material.dart';

import '../style/style.dart';

class Card_employee extends StatefulWidget {
  Color color;
  String empno;
  String ename;
  String job;
  String mgr;
  String hiredate;
  String sal;
  String comm;
  String deptno;
  Card_employee({
    Key? key,
    // required this.number,
    required this.color,
    required this.empno,
    required this.ename,
    required this.job,
    required this.mgr,
    required this.hiredate,
    required this.sal,
    required this.comm,
    required this.deptno,
  }) : super(key: key);

  @override
  State<Card_employee> createState() => _Card_employeeState();
}

class _Card_employeeState extends State<Card_employee> {
  @override
  Widget build(BuildContext context) {
    return cardReservation(context);
  }

  Widget cardReservation(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.0),
          topRight: Radius.circular(5.0),
          bottomLeft: Radius.circular(5.0),
          bottomRight: Radius.circular(5.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "   ",
                style: Style.blackSmallNormal,
              ),
              Text(
                widget.ename.toUpperCase(),
                style: Style.blackSmallBold,
              ),
            ],
          ),
          SizedBox(height: 10),
          iconListCont(context),
        ],
      ),
    );
  }

  Widget iconListCont(BuildContext context) {
    return Column(
      children: listIcons(context),
    );
  }

  List<Widget> listIcons(BuildContext context) {
    List<Widget> aux = [];

    aux.add(
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: typeName(context, "JOB", "${widget.job}"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: typeName(context, "MGR", "${widget.mgr}"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: typeName(context, "COMM", "${widget.comm}"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: typeName(context, "SALARY", "${widget.sal}"),
          ),
        ],
      ),
    );

    aux.add(SizedBox(
      height: 5,
    ));

    aux.add(
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: typeName(context, "DEP", "${widget.deptno}"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: typeName(context, "HIRE", "${widget.hiredate}"),
          ),
        ],
      ),
    );

    return aux;
  }

  Widget typeName(BuildContext context, String type, String text) {
    return Container(
      child: Row(
        children: [
          Text(
            "${type} ",
            style: Style.greySmallNormal,
          ),
          Text(
            "${text}",
            style: Style.blackSmallBold,
          ),
        ],
      ),
    );
  }
}
