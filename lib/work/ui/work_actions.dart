import 'package:equatable/equatable.dart';

class SetAvailableJobsAction extends Equatable {
  final List<String> jobs;

  SetAvailableJobsAction(this.jobs): super([jobs]);
}

class GetAvailableJobsAction extends Equatable {}