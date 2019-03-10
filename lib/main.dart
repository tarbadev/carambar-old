import 'package:carambar/ui/character_tab.dart';
import 'package:carambar/ui/home_tab.dart';
import 'package:flutter/material.dart';

import 'package:carambar/application_injector.dart';
import 'package:flutter/services.dart';

void main() => runApp(CarambarApp());

class CarambarApp extends StatelessWidget {
  CarambarApp() {
    getApplicationInjector().configure();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carambar',
      debugShowCheckedModeBanner: false,
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
    CharacterTab(),
  ];

  void onTabTapped(int index) {
    setState(() {
      selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: tabs.elementAt(selectedTab), padding: EdgeInsets.all(10)),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home', key: Key("bottomNavigationHome"),)),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Character', key: Key("bottomNavigationCharacter"),)),
        ],
        currentIndex: selectedTab,
        fixedColor: Colors.lightBlue,
        onTap: onTabTapped,
      ),
    );
  }
}
