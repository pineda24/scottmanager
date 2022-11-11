import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:scottmanager/pages/departments/departments_list.dart';

import '../pages/departments/department.dart';
import '../pages/employees/employee.dart';
import '../pages/employees/employees_list.dart';

class MenuTabs extends StatefulWidget {
  const MenuTabs();

  @override
  State<MenuTabs> createState() => _MenuTabsState();
}

class _MenuTabsState extends State<MenuTabs> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    int a = 8;
    int b = 28;
    int c = 21;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(
          0xFF40916c,
          {
            50: Color.fromRGBO(a, b, c, .1),
            100: Color.fromRGBO(a, b, c, .2),
            200: Color.fromRGBO(a, b, c, .3),
            300: Color.fromRGBO(a, b, c, .4),
            400: Color.fromRGBO(a, b, c, .5),
            500: Color.fromRGBO(a, b, c, .6),
            600: Color.fromRGBO(a, b, c, .7),
            700: Color.fromRGBO(a, b, c, .8),
            800: Color.fromRGBO(a, b, c, .9),
            900: Color.fromRGBO(a, b, c, 1),
          },
        ),
        primaryColor: Colors.black,
      ),
      home: DefaultTabController(
        length: 2,
        initialIndex: index,
        child: Builder(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                onTap: (value) {
                  setState(() {
                    index = value;
                    // initState();
                  });
                },
                tabs: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Tab(
                      icon: new Image.asset('assets/icons/department.png'),
                      height: 30,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Tab(
                      icon: new Image.asset('assets/icons/employee.png'),
                      height: 30,
                    ),
                  ),
                ],
              ),
              title: Text('SCOTT MANAGER'),
              centerTitle: false,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (index == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Department(
                            action: "create",
                            dpno: -1,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Employee(
                            action: "create",
                            empno: -1,
                          ),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(5),
              child: TabBarView(
                children: [
                  DepartmentsList(),
                  EmployeeList(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class TabScope {
  // singleton class
  static TabScope _tabScope = TabScope();
  int tabIndex = 0;

  static TabScope getInstance() {
    if (_tabScope == null) _tabScope = TabScope();

    return _tabScope;
  }

  void setTabIndex(int index) {
    tabIndex = index;
  }
}
