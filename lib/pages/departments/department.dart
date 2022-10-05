import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../components/button.dart';
import '../../models/department.model.dart';
import '../../style/style.dart';

class Department extends StatefulWidget {
  String action;
  int dpno = 0;

  Department({required this.action});

  @override
  State<Department> createState() => _DepartmentState();
}

class _DepartmentState extends State<Department> {
  List<TextEditingController> controllers =
      List.generate(3, (int index) => TextEditingController());
  Dept department = new Dept(deptno: 0, dname: "", loc: "");

  @override
  void initState() {
    super.initState();
    if (widget.action == "edit") getData();
  }

  Future<void> getData() async {
    try {
      Response res = await get(Uri.http(
          'localhost:8000/ScottManager/departments', '${widget.dpno}'));
      if (res.statusCode == 200) {
        List<dynamic> depts = jsonDecode(res.body)['departments'];
        if (depts.length > 0) {
          department = Dept.fromJson(depts[0]);
          controllers[0].text = department.deptno.toString();
          controllers[1].text = department.dname.toString();
          controllers[2].text = department.loc.toString();
        }
      } else {
        throw "Unable to retrieve posts.";
      }
    } catch (e) {}
  }

  Future<void> saveData() async {
    try {
      var baseUrl = Uri.parse('http://10.0.2.2:8000/ScottManager/departments/');
      Response response;
      var obj = {
        "deptno": controllers[0].text,
        "dname": controllers[1].text,
        "loc": controllers[2].text,
      };
      if (widget.action == "create") {
        response = await post(
          baseUrl,
          body: jsonEncode(obj),
        );
      } else {
        response = await put(
          baseUrl,
          body: obj,
        );
      }

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      Navigator.pop(context);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.action == 'create'
              ? 'CREAR DEPARTAMENTO'
              : 'EDITAR DEPARTAMENTO',
          style: Style.whiteNormalBoldText,
        ),
        backgroundColor: Style.primaryColorBold,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textField(context, 'NUMERO DE DEPARTAMENTO', controllers[0]),
              textField(context, 'DEPARTAMENTO', controllers[1]),
              textField(context, 'LOCALIZACION', controllers[2]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: button(context),
    );
  }

  Widget textField(
      BuildContext context, String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: "${label}",
        ),
      ),
    );
  }

  Widget button(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Button(
        text: "Guardar",
        onPressed: () {
          setState(() {
            saveData();
          });
        },
      ),
    );
  }
}
