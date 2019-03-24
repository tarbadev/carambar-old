import 'package:carambar/work/domain/entity/job.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class DisplayJob extends Equatable {
  final int id;
  final String name;
  final String salary;
  final List<String> requirements;

  DisplayJob(this.id, this.name, this.requirements, this.salary) : super([id, name, requirements, salary]);

  factory DisplayJob.fromJob(Job job) {
    if (job == null) {
      return DisplayJob(
        0,
        'Not employed',
        [''],
        '${NumberFormat.simpleCurrency(decimalDigits: 0).format(0)}/year',
      );
    }

    return DisplayJob(
      job.id,
      job.name,
      job.requirements.map((requirement) => '\u2022 ${_requirementToDisplayRequirement[requirement]}').toList(),
      '${NumberFormat.simpleCurrency(decimalDigits: 0).format(job.salary)}/year',
    );
  }

  static Map<Requirement, String> _requirementToDisplayRequirement = {
    Requirement.HighSchool: 'High School completed successfully',
    Requirement.Supervisor3Years: 'Supervisor for 3+ years',
    Requirement.Teacher5Years: 'Teacher for 5+ years',
    Requirement.Counselor5Years: 'Counselor for 5+ years',
    Requirement.AssociateDirector5Years: 'Associate Director for 5+ years',
  };
}
