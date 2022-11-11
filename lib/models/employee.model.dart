// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Emp welcomeFromJson(String str) => Emp.fromJson(json.decode(str));

String welcomeToJson(Emp data) => json.encode(data.toJson());

class Emp {
  Emp({
    required this.id,
    required this.empno,
    required this.ename,
    required this.job,
    required this.mgr,
    required this.hiredate,
    required this.sal,
    required this.comm,
    required this.deptno,
  });

  String id;
  int empno;
  String ename;
  String job;
  dynamic mgr;
  DateTime hiredate;
  int sal;
  dynamic comm;
  String deptno;

  // factory Emp.fromJson(Map<String, dynamic> json) => Emp(
  //       id: json["_id"],
  //       empno: json["empno"],
  //       ename: json["ename"],
  //       job: json["job"],
  //       mgr: json["mgr"],
  //       hiredate: DateTime.parse(json["hiredate"]),
  //       sal: json["sal"],
  //       comm: json["comm"],
  //       deptno: json["deptno"],
  //     );

  factory Emp.fromJson(Map<String, dynamic> json) => Emp(
        id: json["_id"],
        empno: json["empno"],
        ename: json["ename"],
        job: json["job"],
        mgr: json["mgr"],
        hiredate: DateTime.parse(json["hiredate"]),
        sal: json["sal"],
        comm: json["comm"],
        deptno: json["deptno"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "empno": empno,
        "ename": ename,
        "job": job,
        "mgr": mgr,
        "hiredate": hiredate.toIso8601String(),
        "sal": sal,
        "comm": comm,
        "deptno": deptno,
      };
}
