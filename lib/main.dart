import 'package:carambar/ui/home_tab.dart';
import 'package:flutter/material.dart';

import 'package:carambar/application_injector.dart';

void main() => runApp(CarambarApp());

class CarambarApp extends StatelessWidget {
  CarambarApp() {
    getApplicationInjector().configure();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carambar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedTab = 0;
  final tabs = [
    HomeTab(),
  ];

  void onTabTapped(int index) {
    setState(() {
      selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs.elementAt(selectedTab),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home', key: Key("bottomNavigationHome"),)),
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Test', key: Key("bottomNavigationTest"),)),
        ],
        currentIndex: selectedTab,
        fixedColor: Colors.deepPurple,
        onTap: onTabTapped,
      ),
    );
  }
}
