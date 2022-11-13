import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../components/button.dart';
import '../../models/department.model.dart';
import '../../style/style.dart';

class Department extends StatefulWidget {
  String action;
  int dpno;

  Department({required this.action, required this.dpno});

  @override
  State<Department> createState() => _DepartmentState();
}

class _DepartmentState extends State<Department> {
  List<TextEditingController> controllers =
      List.generate(3, (int index) => TextEditingController());
  Dept department = new Dept(id: "", deptno: 0, dname: "", loc: "");
  List<String> atributes = ["deptno", "dname", "loc"];

  @override
  void initState() {
    super.initState();
    if (widget.action == "edit") getData();
  }

  Future<void> getData() async {
    try {
      Response res = await get(
          Uri.parse('http://10.0.2.2:3000/departments/${widget.dpno}'));
      print(res.statusCode);
      if (res.statusCode == 200) {
        Map<String, dynamic> depts = jsonDecode(res.body);
        department = Dept.fromJson(depts);
        controllers[0].text = department.deptno.toString();
        controllers[1].text = department.dname.toString();
        controllers[2].text = department.loc.toString();
      } else {
        throw "Unable to retrieve posts.";
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveData() async {
    try {
      var baseUrl = Uri.parse('http://10.0.2.2:3000/departments/');
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
        if (response.statusCode == 200) {
          if (jsonDecode(response.body)["message"] == "Success") {
            print(jsonDecode(response.body)["message"]);
          } else {
            jsonDecode(response.body)["error"].forEach((err) {
              print(err);
            });
          }
        } else {
          throw "Unable to retrieve post.";
        }
      } else {
        var json_obj;
        // for (var i = 0; i < controllers.length; i++) {
        //   json_obj = {"atribute": atributes[i], "value": controllers[i].text};
        //   response = await put(
        //     Uri.parse('$baseUrl${widget.dpno}'),
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
        var obj = {
          "deptno": controllers[0].text,
          "dname": controllers[1].text,
          "loc": controllers[2].text,
        };
        response = await put(
          Uri.parse('$baseUrl${widget.dpno}'),
          body: obj,
        );
      }
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
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
              textField(context, 'NUMERO DE DEPARTAMENTO', controllers[0],
                  new AlwaysDisabledFocusNode()),
              textField(context, 'DEPARTAMENTO', controllers[1], null),
              textField(context, 'LOCALIZACION', controllers[2], null),
            ],
          ),
        ),
      ),
      bottomNavigationBar: button(context),
    );
  }

  Widget textField(BuildContext context, String label,
      TextEditingController controller, dynamic disable) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        controller: controller,
        focusNode: disable,
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

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
