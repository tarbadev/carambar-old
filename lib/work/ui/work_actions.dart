import 'package:carambar/work/ui/entity/display_job.dart';
import 'package:equatable/equatable.dart';

class SetAvailableJobsAction extends Equatable {
  final List<DisplayJob> jobs;

  SetAvailableJobsAction(this.jobs): super([jobs]);
}

class GetAvailableJobsAction extends Equatable {}

class DisplayJobRequirementsDialogAction extends Equatable {
  final String job;

  DisplayJobRequirementsDialogAction(this.job): super([job]);
}

class ApplyJobAction extends Equatable {
  final int jobId;

  ApplyJobAction(this.jobId): super([jobId]);
}