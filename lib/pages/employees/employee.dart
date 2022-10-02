import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../components/button.dart';
import '../../style/style.dart';

class Employee extends StatefulWidget {
  String action;

  Employee({super.key, required this.action});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  List<TextEditingController> controllers =
      List.generate(7, (int index) => TextEditingController());
  DateTime _date = DateTime.now();

  void getDataEdit() async {
    var url = Uri.https('example.com', 'whatsit/create');
    var response =
        await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    print(await http.read(Uri.https('example.com', 'foobar.txt')));
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
        onPressed: () {},
      ),
    );
  }

  List<String> texts = ["A", "B"];

  Widget dropDownDept(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: DropdownButtonFormField(
        isExpanded: true,
        value: "A",
        validator: (value) {},
        decoration: InputDecoration(
          labelText: "Departamento",
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        ),
        style: Style.formTextLight,
        items: texts.map<DropdownMenuItem<String>>((e) {
          return DropdownMenuItem(child: Text('$e'), value: e.toString());
        }).toList(),
        onChanged: (value) {},
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
