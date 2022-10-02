import 'dart:ffi';

import 'package:flutter/material.dart';

import '../style/style.dart';

class Card_departments extends StatefulWidget {
  Color color;
  String type;
  int people;
  String loca;
  Card_departments({
    Key? key,
    required this.type,
    // required this.number,
    required this.people,
    required this.color,
    required this.loca,
  }) : super(key: key);

  @override
  State<Card_departments> createState() => _Card_departmentsState();
}

class _Card_departmentsState extends State<Card_departments> {
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
                widget.type,
                style: Style.blackSmallBold,
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              iconListCont(context),
              Spacer(),
              Text(
                "${widget.loca}",
                style: Style.greySmallNormal,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget iconListCont(BuildContext context) {
    return Row(
      children: listIcons(context),
    );
  }

  List<Widget> listIcons(BuildContext context) {
    List<Widget> aux = [];

    aux.add(iconNum(context, Icons.people, "${widget.people}"));

    return aux;
  }

  Widget iconNum(BuildContext context, IconData icon, String numb) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 5),
          Text(
            "${numb}",
            style: Style.blackSmallBold,
          ),
        ],
      ),
    );
  }
}
