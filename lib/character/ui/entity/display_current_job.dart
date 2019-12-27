import 'package:carambar/application/domain/entity/current_job.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class DisplayCurrentJob extends Equatable {
  final int id;
  final String name;
  final String salary;

  DisplayCurrentJob(this.id, this.name, this.salary);

  factory DisplayCurrentJob.fromCurrentJob(CurrentJob currentJob) {
    if (currentJob == null) {
      return DisplayCurrentJob(
        0,
        'Not employed',
        '${NumberFormat.simpleCurrency(decimalDigits: 0).format(0)}/year',
      );
    }

    return DisplayCurrentJob(
      currentJob.id,
      currentJob.name,
      '${NumberFormat.simpleCurrency(decimalDigits: 0).format(currentJob.salary)}/year',
    );
  }

  @override
  List<Object> get props => [id, name, salary];
}
