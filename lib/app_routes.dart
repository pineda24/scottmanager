import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scottmanager/pages/departments/departments_list.dart';
import 'package:scottmanager/pages/employees/employees_list.dart';

import 'components/navigation.dart';

const DepartmentListRoute = '/departmentsList';
const DepartmentRoute = '/departmentsList/department';

const EmployeesListRoute = '/emoloyeesList';
const EmployeeRoute = '/emoloyeesList/employee';

class AppRoutes {
  RouteFactory getRoutes() {
    return (settings) {
      Widget screen;

      switch (settings.name) {
        case DepartmentListRoute:
          screen = DepartmentsList();
          break;
        case EmployeesListRoute:
          screen = EmployeeList();
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }
}
