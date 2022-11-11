import 'dart:convert';

Dept deptFromJson(String str) => Dept.fromJson(json.decode(str));

String deptToJson(Dept data) => json.encode(data.toJson());

class Dept {
  Dept({
    required this.id,
    required this.deptno,
    required this.dname,
    required this.loc,
  });

  String id;
  int deptno;
  String dname;
  String loc;
  int people = 0;
  int noemployees = 0;

  factory Dept.fromJson(Map<String, dynamic> json) => Dept(
        id: json["_id"],
        deptno: json["deptno"],
        dname: json["dname"],
        loc: json["loc"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "deptno": deptno,
        "dname": dname,
        "loc": loc,
      };
}
