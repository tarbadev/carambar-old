import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/home/ui/entity/display_age_event.dart';
import 'package:carambar/home/ui/home_actions.dart';
import 'package:carambar/home/ui/widget/age_event_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class HomeTab extends StatelessWidget {
  HomeTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<ApplicationState, _HomeTabModel>(
      converter: (Store<ApplicationState> store) => _HomeTabModel.create(store),
      builder: (BuildContext context, _HomeTabModel viewModel) => Scaffold(
            body: viewModel.ageEvents.isNotEmpty
                ? AgeEventList(displayAgeEvents: viewModel.ageEvents)
                : Text("Loading..."),
            bottomNavigationBar: MaterialButton(
              key: Key("ageButton"),
              color: Colors.lightBlue,
              onPressed: viewModel.onAgeButtonTapped,
              child: Text(
                "Age",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
    );
  }
}

class _HomeTabModel {
  final List<DisplayAgeEvent> ageEvents;
  final Function() onAgeButtonTapped;

  _HomeTabModel(this.ageEvents, this.onAgeButtonTapped);

  factory _HomeTabModel.create(Store<ApplicationState> store) =>
      _HomeTabModel(store.state.ageEvents, () => store.dispatch(IncrementAgeAction()));
}
