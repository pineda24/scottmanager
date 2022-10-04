import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:scottmanager/pages/employees/employee.dart';
import 'package:http/http.dart' as http;

import '../../components/card_employee.dart';
import '../../models/employee.model.dart';

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

  Future<void> getData() async {
    try {
      var baseUrl = 'http://10.0.2.2:8000/ScottManager/employees';
      Response res = await get(Uri.parse(baseUrl));
      if (res.statusCode == 200) {
        List<dynamic> aux = jsonDecode(res.body)["employees"];
        listEmployees = [];
        for (var i = 0; i < aux.length; i++) {
          listEmployees.add(Emp.fromJson(aux[i]));
        }
      } else {
        throw "Unable to retrieve posts.";
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listEmployees.length,
      itemBuilder: (context, index) {
        final item = listEmployees[index];
        return Dismissible(
          // Each Dismissible must contain a Key. Keys allow Flutter to
          // uniquely identify widgets.
          key: Key("${listEmployees[index].empno}"),
          // Provide a function that tells the app
          // what to do after an item has been swiped away.
          onDismissed: (direction) async {
            // Remove the item from the data source.
            setState(() async {
              await deleteEmployee(listEmployees[index].empno);
              // listEmployees.removeAt(index);
              await getData();
            });

            // // Then show a snackbar.
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //     content: Text('${listEmployees[index].namme} dismissed')));
          },
          background: Container(color: Colors.red),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Employee(
                    action: "edit",
                    empno: listEmployees[index].empno,
                  ),
                ),
              );
            },
            child: Card_employee(
              color: Colors.white,
              comm: "${listEmployees[index].comm}",
              deptno: "${listEmployees[index].deptno}",
              empno: "${listEmployees[index].empno}",
              ename: "${listEmployees[index].ename}",
              hiredate: listEmployees[index].hiredate,
              job: "${listEmployees[index].job}",
              mgr: "${listEmployees[index].mgr}",
              sal: "${listEmployees[index].sal}",
            ),
          ),
        );
      },
    );
  }

  Future<void> deleteEmployee(int id) async {
    try {
      var baseUrl = 'http://10.0.2.2:8000/ScottManager/employees/';
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

  // List<Widget> listEmployees(BuildContext context) {
  //   List<Widget> aux = [];
  //   for (var i = 0; i < 10; i++) {
  //     aux.add(
  //       InkWell(
  //         onTap: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => Employee(
  //                 action: "edit",
  //               ),
  //             ),
  //           );
  //         },
  //         child: Card_employee(
  //           color: Colors.white,
  //           people: 10,
  //           type: "Raul Hiram Pineda Chavez",
  //           loca: "CHIHUAHUA",
  //         ),
  //       ),
  //     );
  //     aux.add(Divider());
  //   }
  //   return aux;
  // }
}
