import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/work/ui/work_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

        if (viewModel.isJobRequirementsDialogVisible) {
          SchedulerBinding.instance.addPostFrameCallback((_) => showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: Text('Job Requirements'),
                    content: Container(
                      child: Text(
                          viewModel.jobRequirements,
                          key: Key('jobRequirements'),
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Close", key: Key('jobRequirementsCloseButton')),
                        onPressed: () {
                          viewModel.onCloseDialogTapped();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  )));
        }

        return ListView.builder(
            key: Key('availableJobs'),
            itemCount: viewModel.availableJobs.length,
            itemBuilder: (BuildContext context, int index) => ListTile(
                onTap: () => viewModel.onAvailableJobTapped(viewModel.availableJobs[index]),
                title: Text(
                  viewModel.availableJobs[index],
                  key: Key('Jobs__$index'),
                )));
      });
}

class _WorkTabModel {
  final List<String> availableJobs;
  final Function() getAvailableJobs;
  final Function(String) onAvailableJobTapped;
  final bool isJobRequirementsDialogVisible;
  final String jobRequirements;
  final Function() onCloseDialogTapped;

  _WorkTabModel(
    this.availableJobs,
    this.getAvailableJobs,
    this.onAvailableJobTapped,
    this.isJobRequirementsDialogVisible,
    this.jobRequirements,
      this.onCloseDialogTapped,
  );

  factory _WorkTabModel.create(Store<ApplicationState> store) {
    return _WorkTabModel(
      store.state.availableJobs,
      () => store.dispatch(GetAvailableJobsAction()),
      (String job) => store.dispatch(DisplayJobRequirementsDialogAction(job)),
      store.state.isJobRequirementsDialogVisible,
      store.state.jobRequirements,
      () => store.dispatch(SetJobRequirementsDialogVisibleAction(false)),
    );
  }
}
