import 'package:equatable/equatable.dart';

class SetAvailableJobsAction extends Equatable {
  final List<String> jobs;

  SetAvailableJobsAction(this.jobs): super([jobs]);
}

class GetAvailableJobsAction extends Equatable {}

class DisplayJobRequirementsDialogAction extends Equatable {
  final String job;

  DisplayJobRequirementsDialogAction(this.job): super([job]);
}

class SetJobRequirementsAction extends Equatable {
  final String jobRequirements;

  SetJobRequirementsAction(this.jobRequirements): super([jobRequirements]);
}

class SetJobRequirementsDialogVisibleAction extends Equatable {
  final bool visible;

  SetJobRequirementsDialogVisibleAction(this.visible): super([visible]);
}