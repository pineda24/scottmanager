import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:scottmanager/models/employee.model.dart';

import '../../components/button.dart';
import '../../models/department.model.dart';
import '../../models/employeeList.model.dart';
import '../../style/style.dart';

class Employee extends StatefulWidget {
  String action;
  int empno;

  Employee({required this.action, required this.empno});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  List<TextEditingController> controllers =
      List.generate(8, (int index) => TextEditingController());
  DateTime _date = DateTime.now();
  DateFormat outputFormat = DateFormat('yyyy-MM-dd');
  List<Dept> listDep = [];
  // Dept deptSelect = new Dept(id: "", deptno: 0, dname: "", loc: "");
  dynamic deptSelect = null;
  dynamic employeeMgrSelect = null;
  Emp employee = new Emp(
      comm: 0,
      deptno: "",
      empno: -1,
      ename: "",
      hiredate: DateTime.now(),
      id: "",
      job: "",
      mgr: "",
      sal: 0);
  int dept = 0;
  List<String> atributes = [
    "empno",
    "ename",
    "job",
    "mgr",
    "hiredate",
    "sal",
    "comm",
    "deptno"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.action == "edit") getData();
  }

  Future<List<Dept>> getDataDept() async {
    try {
      var baseUrl = 'http://localhost:3000/departments';
      Response res = await get(Uri.parse(baseUrl));
      if (res.statusCode == 200) {
        List<dynamic> aux = jsonDecode(res.body);
        List<Dept> listDepart = [];
        for (var i = 0; i < aux.length; i++) {
          // print("AUX: ${aux[i]}");
          Dept department = Dept.fromJson(aux[i]);
          // if (i == 0) deptSelect = department;
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

  Future<List<EmployeeView>> getDataEmplyees() async {
    try {
      var baseUrl = 'http://localhost:3000/employees';
      Response res = await get(Uri.parse(baseUrl));
      if (res.statusCode == 200) {
        List<dynamic> aux = jsonDecode(res.body);
        List<EmployeeView> listempl = [];
        listempl.add(
          EmployeeView(
            comm: null,
            deptno: null,
            hiredate: DateTime.now(),
            empno: -1,
            id: null,
            ename: "",
            job: "",
            mgr: null,
            nameDept: null,
            sal: 0,
          ),
        );
        for (var i = 0; i < aux.length; i++) {
          EmployeeView emp = EmployeeView.fromJson(aux[i]);
          // if (i == 0 && widget.empno != emp.empno) employeeMgrSelect = emp.id;
          if (widget.empno != emp.empno) listempl.add(emp);
        }
        return listempl;
      } else {
        return [];
      }
    } catch (e) {
      throw "Unable to retrieve posts.";
    }
  }

  Future<void> getData() async {
    try {
      Response res = await get(
          Uri.parse('http://localhost:3000/employees/${widget.empno}'));
      if (res.statusCode == 200) {
        print(res.body);
        Map<String, dynamic> depts = jsonDecode(res.body);

        employee = Emp.fromJson(depts);
        controllers[0].text = employee.empno.toString();
        controllers[1].text = employee.ename.toString();
        controllers[2].text = employee.job.toString();
        // controllers[3].text = employee.mgr.toString();
        _date = DateTime.parse(employee.hiredate.toString());
        controllers[4]
          ..text = DateFormat.yMMMd().format(employee.hiredate)
          ..selection = TextSelection.fromPosition(
            TextPosition(
                offset: controllers[4].text.length,
                affinity: TextAffinity.upstream),
          );
        employeeMgrSelect =
            employee.mgr != null ? employee.mgr.toString() : null;

        deptSelect = employee.deptno.toString();
        controllers[5].text = employee.sal.toString();
        controllers[6].text = employee.comm.toString();
        controllers[7].text = employee.deptno.toString();
        //       //   // deptSelect.deptno = employee.deptno;
      } else {
        throw "Unable to retrieve posts.";
      }
    } catch (e) {
      throw "Unable to retrieve posts.";
    }
  }

  // void getData() async {
  //   try {
  //     Response res = await get(
  //         Uri.parse('http://localhost:3000/employees${widget.empno}'));
  //     print(res.statusCode);
  //     if (res.statusCode == 200) {
  //       List<dynamic> emps = jsonDecode(res.body);
  //       print(res.body);
  //       // if (emps.length > 0) {
  //       //   employee = Emp.fromJson(emps[0]);
  //       //   controllers[0].text = employee.empno.toString();
  //       //   controllers[1].text = employee.ename.toString();
  //       //   controllers[2].text = employee.job.toString();
  //       //   controllers[3].text = employee.mgr.toString();
  //       //   _date = DateTime.parse(employee.hiredate.toString());
  //       //   controllers[4]
  //       //     ..text = DateFormat.yMMMd().format(employee.hiredate)
  //       //     ..selection = TextSelection.fromPosition(
  //       //       TextPosition(
  //       //           offset: controllers[4].text.length,
  //       //           affinity: TextAffinity.upstream),
  //       //     );
  //       //   controllers[5].text = employee.sal.toString();
  //       //   controllers[6].text = employee.comm.toString();
  //       //   controllers[7].text = employee.deptno.toString();
  //       //   // deptSelect.deptno = employee.deptno;
  //       // }
  //     } else {
  //       throw "Unable to retrieve posts.";
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  void saveData() async {
    try {
      var baseUrl = Uri.parse('http://localhost:3000/employees/');
      var obj = {
        "empno": controllers[0].text,
        "ename": controllers[1].text,
        "job": controllers[2].text,
        // "mgr": employeeMgrSelect,
        "hiredate": outputFormat.format(_date).toString(),
        "sal": controllers[5].text,
        "comm": controllers[6].text,
        "deptno": deptSelect,
      };
      if (employeeMgrSelect != null) obj["mgr"] = employeeMgrSelect;
      Response response;
      if (widget.action == "create") {
        response = await post(
          baseUrl,
          body: obj,
        );
        // if (response.statusCode == 200) {
        //   // if (jsonDecode(response.body)["message"] == "Success") {
        //   //   print(jsonDecode(response.body)["message"]);
        //   // } else {
        //   //   jsonDecode(response.body)["error"].forEach((err) {
        //   //     print(err);
        //   //   });
        //   // }
        // } else {
        //   throw "Unable to retrieve post.";
        // }
      } else {
        // for (var i = 0; i < controllers.length; i++) {
        //   var json_obj;
        //   if (atributes[i] == "hiredate") {
        //     json_obj = {
        //       "atribute": atributes[i],
        //       "value": outputFormat.format(_date).toString()
        //     };
        //   } else {
        //     json_obj = {"atribute": atributes[i], "value": controllers[i].text};
        //   }
        //   response = await put(
        //     Uri.parse('$baseUrl${widget.empno}'),
        //     body: jsonEncode(json_obj),
        //   );
        //   if (response.statusCode == 200) {
        //     if (jsonDecode(response.body)["message"] == "Success") {
        //       print(jsonDecode(response.body)["message"]);
        //     } else {
        //       jsonDecode(response.body)["error"].forEach((err) {
        //         print(err);
        //       });
        //     }
        //   } else {
        //     throw "Unable to retrieve put.";
        //   }
        // }
        response = await put(
          Uri.parse('$baseUrl${widget.empno}'),
          body: obj,
        );
      }
    } catch (e) {
      print(e);
    }
    Navigator.pop(context);
  }

  void getDept() async {
    try {
      Response res =
          await get(Uri.http('10.20.14.145:8000/ScottManager/', 'departments'));
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
              textField(
                  context,
                  'NUMERO DE EMPLEADO',
                  controllers[0],
                  TextInputType.number,
                  widget.action != "create"
                      ? new AlwaysDisabledFocusNode()
                      : null),
              textField(
                  context, 'NOMBRE', controllers[1], TextInputType.text, null),
              textField(
                  context, 'JOB', controllers[2], TextInputType.text, null),
              // textField(
              //     context, 'MGR', controllers[3], TextInputType.number, null),
              dropDownEmpl(context),
              // textField(context, 'HIRE DATE', controllers[0]),
              dateMatch(context, 'HIRE DATE', controllers[4]),
              textField(context, 'SALARY', controllers[5], TextInputType.number,
                  null),
              textField(context, 'COMMISSION', controllers[6],
                  TextInputType.number, null),
              dropDownDept(context),
              // textField(context, 'DEPARTMENT', controllers[7],
              //     TextInputType.number, null),
            ],
          ),
        ),
      ),
      bottomNavigationBar: button(context),
    );
  }

  Widget textField(
      BuildContext context,
      String label,
      TextEditingController controller,
      TextInputType textInputType,
      dynamic disable) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        controller: controller,
        focusNode: disable,
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
      child: FutureBuilder<List<Dept>>(
        future: getDataDept(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<Dept>> snapshot,
        ) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Text("NO FOUND")
              : DropdownButtonFormField(
                  isExpanded: true,
                  value: deptSelect,
                  validator: (value) {},
                  decoration: InputDecoration(
                    labelText: "Departamento",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  ),
                  style: Style.formTextLight,
                  items: snapshot.data?.map<DropdownMenuItem<String>>((e) {
                    return DropdownMenuItem(
                        child: Text('${e.dname}'), value: e.id.toString());
                  }).toList(),
                  onChanged: (value) {
                    print(value);
                    for (var i = 0; i < snapshot.data!.length; i++) {
                      if (snapshot.data![i].id == value)
                        deptSelect = snapshot.data![i].id;
                    }
                  },
                );
        },
      ),
    );
  }

  Widget dropDownEmpl(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: FutureBuilder<List<EmployeeView>>(
        future: getDataEmplyees(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<EmployeeView>> snapshot,
        ) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Text("NO FOUND")
              : DropdownButtonFormField(
                  isExpanded: true,
                  value: employeeMgrSelect,
                  validator: (value) {},
                  decoration: InputDecoration(
                    labelText: "MGR",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  ),
                  style: Style.formTextLight,
                  items: snapshot.data?.map<DropdownMenuItem<String>>((e) {
                    return DropdownMenuItem(
                        child: Text(e.id == null
                            ? "Ningun manager"
                            : 'No.${e.empno} ${e.ename}'),
                        value: e.id != null ? e.id.toString() : null);
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      for (var i = 0; i < snapshot.data!.length; i++) {
                        if (snapshot.data![i].id == value)
                          employeeMgrSelect = snapshot.data![i].id;
                      }
                    } else {
                      employeeMgrSelect = null;
                    }
                  },
                );
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

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
