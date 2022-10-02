import 'package:flutter/material.dart';
import 'package:scottmanager/pages/departments/department.dart';

import '../../components/card_departments.dart';

class DepartmentsList extends StatefulWidget {
  const DepartmentsList();

  @override
  State<DepartmentsList> createState() => _DepartmentsListState();
}

class _DepartmentsListState extends State<DepartmentsList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: listDepartments(context),
    );
  }

  List<Widget> listDepartments(BuildContext context) {
    List<Widget> aux = [];
    for (var i = 0; i < 10; i++) {
      aux.add(InkWell(
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
          people: 10,
          type: "ADMINISTRACION",
          loca: "CHIHUAHUA",
        ),
      ));
      aux.add(Divider());
    }
    return aux;
  }
}
