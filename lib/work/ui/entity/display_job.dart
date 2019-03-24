import 'package:carambar/work/domain/entity/job.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class DisplayJob extends Equatable {
  final int id;
  final String name;
  final String salary;
  final String requirements;

  DisplayJob(this.id, this.name, this.requirements, this.salary) : super([id, name, requirements, salary]);

  factory DisplayJob.fromJob(Job job) {
    if (job == null) {
      return DisplayJob(
        0,
        'Not employed',
        '',
        '${NumberFormat.simpleCurrency(decimalDigits: 0).format(0)}/year',
      );
    }

    return DisplayJob(
        job.id,
        job.name,
        '\u2022 ${job.requirements}',
        '${NumberFormat.simpleCurrency(decimalDigits: 0).format(job.salary)}/year',
      );
  }
}
