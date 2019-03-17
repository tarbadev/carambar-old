import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/work/ui/entity/display_job.dart';
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
            itemBuilder: (BuildContext context, int index) {
              var job = viewModel.availableJobs[index];

              return ListTile(
                  onTap: () => displayJobRequirements(context, job),
                  title: Text(
                    job.name,
                    key: Key('Jobs__$index'),
                  ));
            });
      });

  Future displayJobRequirements(BuildContext context, DisplayJob job) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            key: Key('JobDialog'),
            title: Container(
              child: Text(
                job.name,
                key: Key('JobDialog__JobTitle'),
              ),
            ),
            content: Container(
              child: Text(
                job.requirements,
                key: Key('JobDialog__JobRequirements'),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Close", key: Key('JobDialog__CloseButton')),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
    );
  }
}

class _WorkTabModel {
  final List<DisplayJob> availableJobs;
  final Function() getAvailableJobs;
  final Function(String) onAvailableJobTapped;

  _WorkTabModel(
    this.availableJobs,
    this.getAvailableJobs,
    this.onAvailableJobTapped,
  );

  factory _WorkTabModel.create(Store<ApplicationState> store) {
    return _WorkTabModel(
      store.state.availableJobs,
      () => store.dispatch(GetAvailableJobsAction()),
      (String job) => store.dispatch(DisplayJobRequirementsDialogAction(job)),
    );
  }
}
