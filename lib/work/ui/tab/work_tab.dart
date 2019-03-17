import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/work/ui/work_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class WorkTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StoreConnector<ApplicationState, _WorkTabModel>(
      converter: (Store<ApplicationState> store) => _WorkTabModel.create(store),
      builder: (BuildContext context, _WorkTabModel viewModel) {
        if (viewModel.availableJobs == null || viewModel.availableJobs.isEmpty) {
          viewModel.getAvailableJobs();
          return Text('Loading...');
        }

        return ListView.builder(
            key: Key('availableJobs'),
            itemCount: viewModel.availableJobs.length,
            itemBuilder: (BuildContext context, int index) => Text(
                  viewModel.availableJobs[index],
                  key: Key('Jobs__$index'),
                ));
      });
}

class _WorkTabModel {
  final List<String> availableJobs;
  final Function() getAvailableJobs;

  _WorkTabModel(this.availableJobs, this.getAvailableJobs);

  factory _WorkTabModel.create(Store<ApplicationState> store) {
    return _WorkTabModel(
      store.state.availableJobs,
      () => store.dispatch(GetAvailableJobsAction()),
    );
  }
}
