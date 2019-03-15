import 'package:carambar/application/ui/application_actions.dart';
import 'package:carambar/application/ui/application_injector.dart';
import 'package:carambar/application/ui/application_middleware.dart';
import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/character/ui/tab/character_tab.dart';
import 'package:carambar/home/ui/tab/home_tab.dart';
import 'package:carambar/settings/ui/tab/settings_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:carambar/application/ui/application_reducer.dart';

void main() {
  runApp(CarambarApp());
}

class CarambarApp extends StatelessWidget {
  final _store = Store<ApplicationState>(
    applicationReducer,
    initialState: ApplicationState.initial(),
    middleware: createApplicationMiddleware(),
  );

  CarambarApp() {
    getApplicationInjector().configure();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
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

  Widget getTab() => tabs.elementAt(selectedTab);

  factory _MainPageModel.create(Store<ApplicationState> store) {
    return _MainPageModel(store.state.currentTab, (int index) => store.dispatch(SelectTabAction(index)));
  }
}
