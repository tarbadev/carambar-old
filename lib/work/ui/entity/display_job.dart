import 'package:carambar/work/domain/entity/job.dart';
import 'package:equatable/equatable.dart';

class DisplayJob extends Equatable {
  final String name;
  final String requirements;

  DisplayJob({this.name, this.requirements}) : super([name, requirements]);

  factory DisplayJob.fromJob(Job job) => DisplayJob(
        name: job.name,
        requirements: job.requirements,
      );
}
