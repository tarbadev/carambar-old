import 'package:carambar/actions.dart';
import 'package:carambar/application_injector.dart';
import 'package:carambar/middleware.dart';
import 'package:carambar/store.dart';
import 'package:carambar/ui/character_tab.dart';
import 'package:carambar/ui/home_tab.dart';
import 'package:carambar/ui/settings_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:carambar/global_reducer.dart';

void main() {
  runApp(CarambarApp());
}

class CarambarApp extends StatelessWidget {
  final _store = Store<GlobalState>(
    globalReducer,
    initialState: GlobalState.initial(),
    middleware: createStoreMiddleware(),
  );

  CarambarApp() {
    getApplicationInjector().configure();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<GlobalState>(
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
    return StoreConnector<GlobalState, _MainPageModel>(
      converter: (Store<GlobalState> store) => _MainPageModel.create(store),
      builder: (BuildContext context, _MainPageModel viewModel) => Scaffold(
            body: Container(child: viewModel.getTab(), padding: EdgeInsets.all(10)),
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    title: Text(
                      'Home',
                      key: Key("bottomNavigationHome"),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    title: Text(
                      'Character',
                      key: Key("bottomNavigationCharacter"),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    title: Text(
                      'Settings',
                      key: Key("bottomNavigationSettings"),
                    )),
              ],
              currentIndex: viewModel.selectedTab,
              fixedColor: Colors.lightBlue,
              onTap: viewModel.onTabTapped,
            ),
          ),
    );
  }
}

class _MainPageModel {
  final selectedTab;
  final Function(int) onTabTapped;

  final tabs = [
    HomeTab(),
    CharacterTab(),
    SettingsTab(),
  ];

  _MainPageModel(this.selectedTab, this.onTabTapped);

  StatefulWidget getTab() => tabs.elementAt(selectedTab);

  factory _MainPageModel.create(Store<GlobalState> store) =>
      _MainPageModel(store.state.currentTab, (int index) => store.dispatch(SelectTabAction(index)));
}
