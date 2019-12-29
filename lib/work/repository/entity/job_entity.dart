import 'package:carambar/work/domain/entity/job.dart';
import 'package:json_annotation/json_annotation.dart';

part 'job_entity.g.dart';

@JsonSerializable(nullable: false)
class JobEntity {
  final int id;
  final String name;
  final double salary;
  final List<String> requirements;
  final List<String> personalityTraits;

  JobEntity({this.id, this.name, this.salary, this.requirements, this.personalityTraits});

  factory JobEntity.fromJson(Map<String, dynamic> json) => _$JobEntityFromJson(json);
  Map<String, dynamic> toJson() => _$JobEntityToJson(this);

  JobEntity.fromJob(Job job)
      : id = job.id,
        name = job.name,
        salary = job.salary,
        requirements = job.requirements.map((requirement) => requirement.toString()).toList(),
        personalityTraits = job.personalityTraits.map((trait) => trait.toString()).toList();

  Job toJob() => Job(
        id: id,
        name: name,
        salary: salary,
        requirements: requirements
            .map((requirement) => Requirement.values.firstWhere((e) => e.toString() == requirement))
            .toList(),
        personalityTraits: personalityTraits
            .map((requirement) => PersonalityTrait.values.firstWhere((e) => e.toString() == requirement))
            .toList(),
      );
}
