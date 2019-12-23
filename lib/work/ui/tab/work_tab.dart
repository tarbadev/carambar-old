import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/work/ui/entity/display_job.dart';
import 'package:carambar/work/ui/widget/job_list_item.dart';
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

        return ListView.separated(
            separatorBuilder: (context, index) => Divider(color: Colors.grey, height: 2),
            key: Key('Work__AvailableJobs'),
            itemCount: viewModel.availableJobs.length,
            itemBuilder: (BuildContext context, int index) {
              var job = viewModel.availableJobs[index];

              return JobListItem(
                titleKey: Key('Work__Jobs__title__$index'),
                job: job,
                onTap: () => _displayJobRequirements(context, job, viewModel.onApplyJobButtonTapped),
                isCurrentJob: viewModel.isCurrentJob(job),
              );
            });
      });

  void _displayJobRequirements(
      BuildContext context, DisplayJob displayJob, Function(int) onApplyTapped) {
    var index = 0;
    var requirements = displayJob.requirements
        .map((requirement) => Text(
              requirement,
              key: Key('JobDialog__JobRequirements__${index++}'),
              style: Theme.of(context).textTheme.body1,
            ))
        .toList();

    index = 0;
    var personalityTraits = displayJob.personalityTraits
        .map((personalityTrait) => Text(
              personalityTrait,
              key: Key('JobDialog__JobPersonalityTraits__${index++}'),
              style: Theme.of(context).textTheme.body1,
            ))
        .toList();

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        key: Key('JobDialog'),
        titlePadding: EdgeInsets.all(0),
        title: Container(
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Text(
            displayJob.name,
            key: Key('JobDialog__JobTitle'),
            style: TextStyle(color: Colors.white),
          ),
        ),
        content: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Requirements',
                style: Theme.of(context).textTheme.subhead,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                key: Key('JobDialog__JobRequirements'),
                children: requirements,
              ),
              Divider(height: 10),
              Text(
                'Personality traits',
                style: Theme.of(context).textTheme.subhead,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                key: Key('JobDialog__JobPersonalityTraits'),
                children: personalityTraits,
              ),
              Divider(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Text(
                      'Salary',
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ),
                  Text(
                    displayJob.salary,
                    key: Key('JobDialog__JobSalary'),
                    style: Theme.of(context).textTheme.body1,
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Close', key: Key('JobDialog__CloseButton')),
            onPressed: () => Navigator.of(context).pop(),
          ),
          MaterialButton(
            elevation: 2,
            color: ThemeData.light().primaryColor,
            textTheme: ButtonTextTheme.primary,
            key: Key('JobDialog__ApplyButton'),
            child: Text('Apply'),
            onPressed: () {
              onApplyTapped(displayJob.id);
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
  final Function(int) onApplyJobButtonTapped;
  final bool Function(DisplayJob) isCurrentJob;

  _WorkTabModel(
    this.availableJobs,
    this.getAvailableJobs,
    this.onApplyJobButtonTapped,
    this.isCurrentJob,
  );

  factory _WorkTabModel.create(Store<ApplicationState> store) {
    return _WorkTabModel(
        store.state.availableJobs,
        () => store.dispatch(GetAvailableJobsAction()),
        (int jobId) => store.dispatch(ApplyJobAction(jobId)),
        (DisplayJob job) => job.id == store.state.character.currentJob?.id);
  }
}
