import 'package:flutter/material.dart';
import 'package:scottmanager/style/style.dart';

class Navigation extends StatelessWidget {
  Navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationStatefulWidget();
  }
}

class NavigationStatefulWidget extends StatefulWidget {
  const NavigationStatefulWidget({Key? key}) : super(key: key);

  @override
  State<NavigationStatefulWidget> createState() =>
      _NavigationStatefulWidgetState();
}

class _NavigationStatefulWidgetState extends State<NavigationStatefulWidget> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Container(),
  ];

  @override
  void initState() {
    super.initState();
    _init(context);
  }

  void _init(context) async {}

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.secundaryBackgroundColor,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendario',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        iconSize: 30.0,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Style.primaryColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
      ),
    );
  }
}
