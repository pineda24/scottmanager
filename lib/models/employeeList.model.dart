// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:http/retry.dart';

EmployeeView welcomeFromJson(String str) =>
    EmployeeView.fromJson(json.decode(str));

String welcomeToJson(EmployeeView data) => json.encode(data.toJson());

class EmployeeView {
  EmployeeView({
    required this.id,
    required this.empno,
    required this.ename,
    required this.job,
    required this.mgr,
    required this.hiredate,
    required this.sal,
    required this.comm,
    required this.deptno,
    required this.nameDept,
  });

  String id;
  int empno;
  String ename;
  String job;
  dynamic mgr;
  DateTime hiredate;
  int sal;
  dynamic comm;
  dynamic deptno;
  dynamic nameDept;

  // factory EmployeeView.fromJson(Map<String, dynamic> json) => EmployeeView(
  //       id: json["_id"],
  //       empno: json["empno"],
  //       ename: json["ename"],
  //       job: json["job"],
  //       mgr: json["mgr"],
  //       hiredate: json["hiredate"],
  //       sal: json["sal"],
  //       comm: json["comm"],
  //       deptno: json["deptno"],
  //       nameDept: json["nameDept"],
  //     );

  factory EmployeeView.fromJson(Map<String, dynamic> json) => EmployeeView(
        id: json["_id"],
        empno: json["empno"],
        ename: json["ename"],
        job: json["job"],
        mgr: json["mgr"],
        hiredate: DateTime.parse(json["hiredate"]),
        sal: json["sal"],
        comm: json["comm"],
        deptno: json["deptno"],
        nameDept: json["nameDept"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "empno": empno,
        "ename": ename,
        "job": job,
        "mgr": mgr,
        "hiredate": hiredate,
        "sal": sal,
        "comm": comm,
        "deptno": deptno,
        "nameDept": nameDept,
      };
}
