import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../../components/button.dart';
import '../../models/department.model.dart';
import '../../style/style.dart';

class Employee extends StatefulWidget {
  String action;

  Employee({required this.action});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  List<TextEditingController> controllers =
      List.generate(7, (int index) => TextEditingController());
  DateTime _date = DateTime.now();
  DateFormat outputFormat = DateFormat('yyyy/MM/dd');
  List<Dept> listDep = [];
  Dept deptSelect = new Dept(deptno: 0, dname: "", loc: "");
  int dept = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDept2();
  }

  String prueba =
      '{"message": "Success","departments": [{"deptno": 23, "dname": "hiredate", "loc": "2001-11-14"}, {"deptno": 40,"dname": "OPERATIONS","loc": "BOSTON"}]}';

  void getDataEdit() async {}

  void saveData() async {
    try {
      var url = Uri.https('localhost:8000/ScottManager/employees');
      var response = await post(
        url,
        body: {
          "empno": controllers[0].text,
          "ename": controllers[1].text,
          "job": controllers[2].text,
          "mgr": controllers[3].text,
          "hiredate": outputFormat.format(_date),
          "sal": controllers[5].text,
          "comm": controllers[6].text,
          "deptno": deptSelect.deptno,
        },
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      Navigator.pop(context);
    } catch (e) {}
  }

  void getDept() async {
    try {
      Response res =
          await get(Uri.http('10.0.2.2:8000/ScottManager/', 'departments'));
      if (res.statusCode == 200) {
        List<dynamic> aux = jsonDecode(res.body)["departments"];
        listDep = [];
        for (var i = 0; i < aux.length; i++) {
          listDep.add(Dept.fromJson(aux[i]));
        }
      } else {
        throw "Unable to retrieve posts.";
      }
    } catch (e) {}
  }

  void getDept2() async {
    try {
      List<dynamic> aux = jsonDecode(prueba)["departments"];
      listDep = [];
      for (var i = 0; i < aux.length; i++) {
        if (i == 0) {
          setState(() {
            deptSelect = Dept.fromJson(aux[i]);
          });
        }
        listDep.add(Dept.fromJson(aux[i]));
        print(listDep[i].dname);
      }
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
          widget.action == 'create' ? 'CREAR EMPLEADOS' : 'EDITAR EMPLEADOS',
          style: Style.whiteNormalBoldText,
        ),
        backgroundColor: Style.primaryColorBold,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textField(context, 'NUMERO DE EMPLEADO', controllers[0],
                  TextInputType.text),
              textField(context, 'NOMBRE', controllers[1], TextInputType.text),
              textField(context, 'JOB', controllers[2], TextInputType.text),
              textField(context, 'MGR', controllers[3], TextInputType.number),
              // textField(context, 'HIRE DATE', controllers[0]),
              dateMatch(context, 'HIRE DATE', controllers[4]),
              textField(
                  context, 'SALARY', controllers[5], TextInputType.number),
              textField(
                  context, 'COMMISSION', controllers[6], TextInputType.number),
              dropDownDept(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: button(context),
    );
  }

  Widget textField(BuildContext context, String label,
      TextEditingController controller, TextInputType textInputType) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
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
          saveData();
        },
      ),
    );
  }

  Widget dropDownDept(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: DropdownButtonFormField(
        isExpanded: true,
        value: deptSelect.dname,
        validator: (value) {},
        decoration: InputDecoration(
          labelText: "Departamento",
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        ),
        style: Style.formTextLight,
        items: listDep.map<DropdownMenuItem<String>>((e) {
          return DropdownMenuItem(
              child: Text('${e.dname}'), value: e.dname.toString());
        }).toList(),
        onChanged: (value) {
          for (var i = 0; i < listDep.length; i++) {
            if (listDep[i].dname == value) deptSelect = listDep[i];
          }
        },
      ),
    );
  }

  Widget dateMatch(
      BuildContext context, String text, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        // focusNode: AlwaysDisabledFocusNode(),
        validator: (value) {
          if (_date == null) return "Campo vacio";
          // _date = DateTime.parse(value);
          if (!DateTime.now().isAfter(_date)) return "Fecha no valida";
          return null;
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: "${text}",
        ),
        controller: controller,
        onTap: () {
          _selectDate(context, controller);
        },
      ),
    );
  }

  void _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (newSelectedDate != null) {
      _date = newSelectedDate;
      controller
        ..text = DateFormat.yMMMd().format(newSelectedDate)
        ..selection = TextSelection.fromPosition(
          TextPosition(
              offset: controller.text.length, affinity: TextAffinity.upstream),
        );
    } else {
      _date = DateTime.now();
    }
  }
}
