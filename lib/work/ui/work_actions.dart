import 'package:carambar/work/ui/entity/display_job.dart';
import 'package:equatable/equatable.dart';

class SetAvailableJobsAction extends Equatable {
  final List<DisplayJob> jobs;

  SetAvailableJobsAction(this.jobs);

  @override
  List<Object> get props => [jobs];
}

class GetAvailableJobsAction extends Equatable {

  @override
  List<Object> get props => [];
}

class DisplayJobRequirementsDialogAction extends Equatable {
  final String job;

  DisplayJobRequirementsDialogAction(this.job);

  @override
  List<Object> get props => [job];
}

class ApplyJobAction extends Equatable {
  final int jobId;

  ApplyJobAction(this.jobId);

  @override
  List<Object> get props => [jobId];
}