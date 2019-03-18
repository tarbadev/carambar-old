import 'package:carambar/application/ui/application_actions.dart';
import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/character/ui/tab/character_tab.dart';
import 'package:carambar/home/ui/tab/home_tab.dart';
import 'package:carambar/settings/ui/tab/settings_tab.dart';
import 'package:carambar/work/ui/tab/work_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:redux/redux.dart';

class CarambarApp extends StatelessWidget {
  CarambarApp() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    final container = kiwi.Container();
    final _store = container<Store<ApplicationState>>();

    _store.dispatch(InitiateStateAction());

    return StoreProvider<ApplicationState>(
        store: _store,
        child: MaterialApp(
          title: 'Carambar',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: _MainPage(),
        ));
  }
}

class _MainPage extends StatelessWidget {
  _MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<ApplicationState, _MainPageModel>(
      converter: (Store<ApplicationState> store) => _MainPageModel.create(store),
      builder: (BuildContext context, _MainPageModel viewModel) => SafeArea(
            child: Scaffold(
              appBar: AppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                Text(
                  viewModel.availableCash,
                  key: Key('availableCash'),
                )
              ])),
              body: Container(
                padding: EdgeInsets.all(10),
                child: viewModel.getTab(),
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      title: Text(
                        'Home',
                        key: Key('bottomNavigationHome'),
                      )),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      title: Text(
                        'Character',
                        key: Key('bottomNavigationCharacter'),
                      )),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.work),
                      title: Text(
                        'Jobs',
                        key: Key('bottomNavigationWork'),
                      )),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      title: Text(
                        'Settings',
                        key: Key('bottomNavigationSettings'),
                      )),
                ],
                currentIndex: viewModel.selectedTab,
                fixedColor: Colors.lightBlue,
                onTap: viewModel.onTabTapped,
              ),
            ),
          ),
    );
  }
}

class _MainPageModel {
  final int selectedTab;
  final Function(int) onTabTapped;
  final String availableCash;

  final tabs = [
    HomeTab(),
    CharacterTab(),
    WorkTab(),
    SettingsTab(),
  ];

  _MainPageModel(this.selectedTab, this.onTabTapped, this.availableCash);

  Widget getTab() => tabs.elementAt(selectedTab);

  factory _MainPageModel.create(Store<ApplicationState> store) {
    return _MainPageModel(store.state.currentTab, (int index) => store.dispatch(SelectTabAction(index)),
        NumberFormat.simpleCurrency().format(store.state.availableCash));
  }
}
