import 'dart:convert';

Emp empFromJson(String str) => Emp.fromJson(json.decode(str));

String empToJson(Emp data) => json.encode(data.toJson());

class Emp {
    Emp({
        required this.empno,
        required this.ename,
        required this.job,
        required this.mgr,
        required this.hiredate,
        required this.sal,
        required this.comm,
        required this.deptno,
    });

    int empno;
    String ename;
    String job;
    int mgr;
    DateTime hiredate;
    String sal;
    dynamic comm;
    int deptno;

    factory Emp.fromJson(Map<String, dynamic> json) => Emp(
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