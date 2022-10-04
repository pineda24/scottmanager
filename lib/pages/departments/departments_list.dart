import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:scottmanager/pages/departments/department.dart';

import '../../components/card_departments.dart';
import '../../models/department.model.dart';

class DepartmentsList extends StatefulWidget {
  const DepartmentsList();

  @override
  State<DepartmentsList> createState() => _DepartmentsListState();
}

class _DepartmentsListState extends State<DepartmentsList> {
  List<Dept> listDept = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listDept.length,
      itemBuilder: (context, index) {
        final item = listDept[index];
        return Dismissible(
          // Each Dismissible must contain a Key. Keys allow Flutter to
          // uniquely identify widgets.
          key: Key("${listDept[index].deptno}"),
          // Provide a function that tells the app
          // what to do after an item has been swiped away.
          onDismissed: (direction) {
            // Remove the item from the data source.
            setState(() {
              listDept.removeAt(index);
            });

            // // Then show a snackbar.
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //     content: Text('${listEmployees[index].namme} dismissed')));
          },
          // Show a red background as the item is swiped away.
          background: Container(color: Colors.red),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Department(
                    action: "edit",
                  ),
                ),
              );
            },
            child: Card_departments(
              color: Colors.white,
              deptno: "${listDept[index].deptno}",
              dname: "${listDept[index].dname}",
              people: "${15}",
              loc: "${listDept[index].loc}",
            ),
          ),
        );
      },
    );
    ;
  }

  Future<void> getData() async {
    try {
      Response res =
          await get(Uri.http('localhost:8000/ScottManager/', 'departments'));
      if (res.statusCode == 200) {
        List<dynamic> aux = jsonDecode(res.body);
        listDept = [];
        for (var i = 0; i < aux.length; i++) {
          listDept.add(Dept.fromJson(aux[i]));
        }
      } else {
        throw "Unable to retrieve posts.";
      }
    } catch (e) {}
  }
}
