import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:scottmanager/pages/employees/employee.dart';
import 'package:http/http.dart' as http;

import '../../components/card_employee.dart';
import '../../models/employee.model.dart';
import '../../models/employeeList.model.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList();

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  List<Emp> listEmployees = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  // Future<void> getData() async {
  //   try {
  //     var baseUrl = 'http://localhost:3000/employees';
  //     Response res = await get(Uri.parse(baseUrl));
  //     if (res.statusCode == 200) {
  //       List<dynamic> aux = jsonDecode(res.body)["employees"];
  //       listEmployees = [];
  //       for (var i = 0; i < aux.length; i++) {
  //         listEmployees.add(Emp.fromJson(aux[i]));
  //       }
  //     } else {
  //       throw "Unable to retrieve posts.";
  //     }
  //   } catch (e) {}
  // }

  Future<List<EmployeeView>> getData() async {
    try {
      var baseUrl = 'http://localhost:3000/employees';
      Response res = await get(Uri.parse(baseUrl));
      if (res.statusCode == 200) {
        List<dynamic> aux = jsonDecode(res.body);
        List<EmployeeView> listempl = [];
        for (var i = 0; i < aux.length; i++) {
          listempl.add(EmployeeView.fromJson(aux[i]));
        }
        return listempl;
      } else {
        return [];
      }
    } catch (e) {
      throw "Unable to retrieve posts.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EmployeeView>>(
      future: getData(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<EmployeeView>> snapshot,
      ) {
        return snapshot.connectionState == ConnectionState.waiting
            ? Text("NO FOUND")
            : ListView.builder(
                itemCount: (snapshot.data != null) ? snapshot.data!.length : 0,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  return Dismissible(
                    key: Key("${snapshot.data![index].id}"),
                    onDismissed: (direction) async {
                      await deleteEmployee(snapshot.data![index].empno);
                      setState(() {
                        // listDept.removeAt(index);
                        // await getData();
                      });
                    },
                    background: Container(color: Colors.red),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Employee(
                              action: "edit",
                              empno: snapshot.data![index].empno,
                            ),
                          ),
                        );
                      },
                      child: Card_employee(
                        color: Colors.white,
                        comm: "${snapshot.data![index].comm}",
                        deptno: "${snapshot.data![index].nameDept}",
                        empno: "${snapshot.data![index].empno}",
                        ename: "${snapshot.data![index].ename}",
                        hiredate: snapshot.data![index].hiredate,
                        job: "${snapshot.data![index].job}",
                        mgr: "${snapshot.data![index].mgr}",
                        sal: "${snapshot.data![index].sal}",
                      ),
                      // child: Text("HOLAAAA"),
                    ),
                  );
                },
              );
      },
    );
  }

  Future<void> deleteEmployee(int id) async {
    try {
      var baseUrl = 'http://10.20.14.145:8000/ScottManager/employees/';
      Response res = await delete(Uri.parse('$baseUrl$id'));
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["message"] == "Success") {
          print(jsonDecode(res.body)["message"]);
        } else {
          jsonDecode(res.body)["error"].forEach((err) {
            print(err);
          });
        }
      } else {
        throw "Unable to retrieve delete.";
      }
    } catch (e) {
      print(e);
    }
  }
}
