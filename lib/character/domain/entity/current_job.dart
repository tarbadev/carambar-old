import 'package:carambar/work/domain/entity/job.dart';
import 'package:equatable/equatable.dart';

class CurrentJob extends Equatable {
  final int id;
  final String name;
  final double salary;

  CurrentJob({this.id, this.name, this.salary}): super([id, name, salary]);

  factory CurrentJob.fromJob(Job job) => CurrentJob(
    id: job.id,
    name: job.name,
    salary: job.salary,
  );
}