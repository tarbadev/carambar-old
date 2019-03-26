import 'package:carambar/work/domain/entity/job.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class DisplayJob extends Equatable {
  final int id;
  final String name;
  final String salary;
  final List<String> requirements;
  final List<String> personalityTraits;

  DisplayJob(this.id, this.name, this.requirements, this.salary, this.personalityTraits) : super([id, name, requirements, salary, personalityTraits]);

  factory DisplayJob.fromJob(Job job) {
    return DisplayJob(
      job.id,
      job.name,
      job.requirements.map((requirement) => '\u2022 ${_requirementToDisplayRequirement[requirement]}').toList(),
      '${NumberFormat.simpleCurrency(decimalDigits: 0).format(job.salary)}/year',
        job.personalityTraits.map((personalityTrait) => '\u2022 ${_personalityTraitToDisplayPersonalityTrait[personalityTrait]}').toList(),
    );
  }

  static Map<Requirement, String> _requirementToDisplayRequirement = {
    Requirement.HighSchool: 'High School completed successfully',
    Requirement.Supervisor3Years: 'Supervisor for 3+ years',
    Requirement.Teacher5Years: 'Teacher for 5+ years',
    Requirement.Counselor5Years: 'Counselor for 5+ years',
    Requirement.AssociateDirector5Years: 'Associate Director for 5+ years',
  };

  static Map<PersonalityTrait, String> _personalityTraitToDisplayPersonalityTrait = {
    PersonalityTrait.Charismatic: 'Charismatic',
  };
}
