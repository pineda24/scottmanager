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
    print("GET DATA DEPARTMENTS");
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //   itemCount: listDept.length,
    //   itemBuilder: (context, index) {
    //     print(index);
    //     final item = listDept[index];
    //     return Dismissible(
    //       key: Key("${listDept[index].deptno}"),
    //       onDismissed: (direction) async {
    //         // Remove the item from the data source.
    //         setState(() async {
    //           await deleteDepartment(listDept[index].deptno);
    //           // listDept.removeAt(index);
    //           await getData();
    //         });
    //       },
    //       background: Container(color: Colors.red),
    //       child: InkWell(
    //         onTap: () {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => Department(
    //                 action: "edit",
    //                 dpno: listDept[index].deptno,
    //               ),
    //             ),
    //           );
    //         },
    //         // child: Card_departments(
    //         //   color: Colors.white,
    //         //   deptno: "${listDept[index].deptno}",
    //         //   dname: "${listDept[index].dname}",
    //         //   people: "${0}",
    //         //   loc: "${listDept[index].loc}",
    //         // ),
    //         child: Text("HOLAAAA"),
    //       ),
    //     );
    //   },
    // );
    return FutureBuilder<List<Dept>>(
      future: getData(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<Dept>> snapshot,
      ) {
        // return snapshot.connectionState == ConnectionState.waiting
        //     ? Text("NO FOUND")
        //     : Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         mainAxisSize: MainAxisSize.min,
        //         children: List.generate(
        //           snapshot.data!.length,
        //           (index) {
        //             print("INDEX ${index}");
        //             return Text("snapshot.data?[index]");
        //           },
        //         ),
        //       );
        return snapshot.connectionState == ConnectionState.waiting
            ? Text("NO FOUND")
            : ListView.builder(
                itemCount: (snapshot.data != null) ? snapshot.data!.length : 0,
                itemBuilder: (context, index) {
                  print(index);
                  final item = snapshot.data![index];
                  return Dismissible(
                    key: Key("${snapshot.data![index].deptno}"),
                    onDismissed: (direction) async {
                      // Remove the item from the data source.
                      await deleteDepartment(snapshot.data![index].deptno);
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
                            builder: (context) => Department(
                              action: "edit",
                              dpno: snapshot.data![index].deptno,
                            ),
                          ),
                        );
                      },
                      child: Card_departments(
                        color: Colors.white,
                        deptno: "${snapshot.data![index].deptno}",
                        dname: "${snapshot.data![index].dname}",
                        people: "${snapshot.data![index].noemployees}",
                        loc: "${snapshot.data![index].loc}",
                      ),
                    ),
                  );
                },
              );
      },
    );
  }

  Future<List<Dept>> getData() async {
    try {
      var baseUrl = 'http://localhost:3000/departments';
      Response res = await get(Uri.parse(baseUrl));
      if (res.statusCode == 200) {
        List<dynamic> aux = jsonDecode(res.body);
        List<Dept> listDepart = [];
        for (var i = 0; i < aux.length; i++) {
          // print("AUX: ${aux[i]}");
          Dept department = Dept.fromJson(aux[i]);
          department.noemployees = aux[i]["noemployees"];
          listDepart.add(department);
        }
        return listDepart;
      } else {
        return [];
      }
    } catch (e) {
      throw "Unable to retrieve posts.";
    }
  }

  Future<void> deleteDepartment(int id) async {
    try {
      var baseUrl = 'http://localhost:3000/departments/';
      Response res = await delete(Uri.parse('$baseUrl$id'));
      if (res.statusCode == 200) {
        // if (jsonDecode(res.body)["message"] == "Success") {
        //   print(jsonDecode(res.body)["message"]);
        // } else {
        //   jsonDecode(res.body)["error"].forEach((err) {
        //     print(err);
        //   });
        // }
      } else {
        throw "Unable to retrieve delete.";
      }
    } catch (e) {
      print(e);
    }
  }
}
