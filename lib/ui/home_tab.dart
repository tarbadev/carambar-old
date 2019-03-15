import 'package:carambar/actions.dart';
import 'package:carambar/global_state.dart';
import 'package:carambar/ui/entity/display_age_event.dart';
import 'package:carambar/ui/widget/age_event_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class HomeTab extends StatelessWidget {
  HomeTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<GlobalState, _HomeTabModel>(
      converter: (Store<GlobalState> store) => _HomeTabModel.create(store),
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

  factory _HomeTabModel.create(Store<GlobalState> store) =>
      _HomeTabModel(store.state.ageEvents, () => store.dispatch(IncrementAgeAction()));
}
