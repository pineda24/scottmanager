import 'package:flutter/material.dart';
import 'package:scottmanager/pages/employees/employee.dart';
import 'package:http/http.dart' as http;

import '../../components/card_employee.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList();

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void getEmployeesList() async {
    var url = Uri.https('example.com', 'whatsit/create');
    var response =
        await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    print(await http.read(Uri.https('example.com', 'foobar.txt')));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: listEmployees(context),
    );
  }

  List<Widget> listEmployees(BuildContext context) {
    List<Widget> aux = [];
    for (var i = 0; i < 10; i++) {
      aux.add(
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Employee(
                  action: "edit",
                ),
              ),
            );
          },
          child: Card_employee(
            color: Colors.white,
            people: 10,
            type: "Raul Hiram Pineda Chavez",
            loca: "CHIHUAHUA",
          ),
        ),
      );
      aux.add(Divider());
    }
    return aux;
  }
}
