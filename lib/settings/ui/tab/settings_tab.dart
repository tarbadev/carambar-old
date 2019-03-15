import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/settings/ui/settings_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class SettingsTab extends StatefulWidget {
  SettingsTab({Key key}) : super(key: key);

  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  void initState() {
    super.initState();
  }

  void _onEndLifeButtonPressed() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("End Life ?"),
            content:
                new Text("Are you sure you want to end the life of your character?\nA new character will be generated"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Nevermind..."),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              StoreConnector<ApplicationState, _SettingsTabModel>(
                converter: (Store<ApplicationState> store) => _SettingsTabModel.create(store),
                builder: (BuildContext context, _SettingsTabModel viewModel) => FlatButton(
                      child: new Text("I'm done with it!", key: Key('endLifeConfirmButton')),
                      onPressed: () async {
                        viewModel.onEndLifeConfirmTapped();
                        Navigator.of(context).pop();
                      },
                    ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MaterialButton(
          key: Key('endLifeButton'),
          child: Text('End Life'),
          onPressed: _onEndLifeButtonPressed,
        )
      ],
    );
  }
}

class _SettingsTabModel {
  final Function() onEndLifeConfirmTapped;

  _SettingsTabModel(this.onEndLifeConfirmTapped);

  factory _SettingsTabModel.create(Store<ApplicationState> store) =>
      _SettingsTabModel(() {
        store.dispatch(EndLifeAction());
      });
}
