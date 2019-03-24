import 'package:carambar/work/domain/entity/job.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class DisplayJob extends Equatable {
  final String name;
  final String salary;
  final String requirements;

  DisplayJob({this.name, this.requirements, this.salary}) : super([name, requirements, salary]);

  factory DisplayJob.fromJob(Job job) => DisplayJob(
        name: job.name,
        salary: '${NumberFormat.simpleCurrency(decimalDigits: 0).format(job.salary)}/year',
        requirements: '\u2022 ${job.requirements}',
      );
}
