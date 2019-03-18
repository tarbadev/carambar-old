import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/settings/ui/settings_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class SettingsTab extends StatelessWidget {
  SettingsTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StoreConnector<ApplicationState, _SettingsTabModel>(
        converter: (Store<ApplicationState> store) => _SettingsTabModel.create(store),
        builder: (BuildContext context, _SettingsTabModel viewModel) {
          if (viewModel.isEndLifeDialogVisible) {
            SchedulerBinding.instance.addPostFrameCallback((_) => showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                        key: Key('EndLifeDialog'),
                        title: Text('End Life ?'),
                        content: Text(
                            'Are you sure you want to end the life of your character?\nA new character will be generated'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Nevermind...', key: Key('EndLifeDialog__CancelButton')),
                            onPressed: () {
                              viewModel.onEndLifeCancelTapped();
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text('I\'m done with it!', key: Key('EndLifeDialog__ConfirmButton')),
                            onPressed: () {
                              viewModel.onEndLifeConfirmTapped();
                              Navigator.of(context).pop();
                            },
                          ),
                        ])));
          }

          return Container(
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
            Container(
                width: double.infinity,
                child: MaterialButton(
                  elevation: 2,
                  color: ThemeData.light().primaryColor,
                  textTheme: ButtonTextTheme.primary,
                  key: Key('Settings__EndLifeButton'),
                  child: Text('End Life'),
                  onPressed: viewModel.onEndLifeButtonTapped,
                ))
          ]));
        },
      );
}

class _SettingsTabModel {
  final Function() onEndLifeButtonTapped;
  final bool isEndLifeDialogVisible;
  final Function() onEndLifeConfirmTapped;
  final Function() onEndLifeCancelTapped;

  _SettingsTabModel(
      this.onEndLifeButtonTapped, this.isEndLifeDialogVisible, this.onEndLifeConfirmTapped, this.onEndLifeCancelTapped);

  factory _SettingsTabModel.create(Store<ApplicationState> store) {
    return _SettingsTabModel(
        () => store.dispatch(SetEndLifeDialogVisibleAction(true)), store.state.isEndLifeDialogVisible, () {
      store.dispatch(EndLifeAction());
      store.dispatch(SetEndLifeDialogVisibleAction(false));
    }, () => store.dispatch(SetEndLifeDialogVisibleAction(false)));
  }
}
