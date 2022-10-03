import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:scottmanager/pages/employees/employee.dart';
import 'package:http/http.dart' as http;

import '../../components/card_employee.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList();

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  List<Widget> listEmployees = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> getData() async {
    // Response res = await get(Uri.http('localhost:3000', 'team'));
    // if (res.statusCode == 200) {
    //   List<dynamic> aux = jsonDecode(res.body);
    //   List<Team> teams = [];
    //   for (var i = 0; i < aux.length; i++) {
    //     teams.add(Team.fromJson(aux[i]));
    //   }

    //   return teams;
    // } else {
    //   throw "Unable to retrieve posts.";
    // }
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
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        final item = items[index];
        return Dismissible(
          // Each Dismissible must contain a Key. Keys allow Flutter to
          // uniquely identify widgets.
          key: Key("${index}"),
          // Provide a function that tells the app
          // what to do after an item has been swiped away.
          onDismissed: (direction) {
            // Remove the item from the data source.
            setState(() {
              items.removeAt(index);
            });

            // Then show a snackbar.
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('$item dismissed')));
          },
          // Show a red background as the item is swiped away.
          background: Container(color: Colors.red),
          child: ListTile(
            title: Text(item),
          ),
        );
      },
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
