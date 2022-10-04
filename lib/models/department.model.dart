import 'dart:convert';

Dept deptFromJson(String str) => Dept.fromJson(json.decode(str));

String deptToJson(Dept data) => json.encode(data.toJson());

class Dept {
    Dept({
        required this.deptno,
        required this.dname,
        required this.loc,
    });

    int deptno;
    String dname;
    String loc;

    factory Dept.fromJson(Map<String, dynamic> json) => Dept(
        deptno: json["deptno"],
        dname: json["dname"],
        loc: json["loc"],
    );

    Map<String, dynamic> toJson() => {
        "deptno": deptno,
        "dname": dname,
        "loc": loc,
    };
}