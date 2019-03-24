import 'package:carambar/work/domain/entity/job.dart';
import 'package:json_annotation/json_annotation.dart';

part 'job_entity.g.dart';

@JsonSerializable(nullable: false)
class JobEntity {
  final int id;
  final String name;
  final double salary;
  final List<String> requirements;

  JobEntity({this.id, this.name, this.salary, this.requirements});

  factory JobEntity.fromJson(Map<String, dynamic> json) => _$JobEntityFromJson(json);
  Map<String, dynamic> toJson() => _$JobEntityToJson(this);

  JobEntity.fromJob(Job job)
      : id = job.id,
        name = job.name,
        salary = job.salary,
        requirements = job.requirements.map((requirement) => requirement.toString()).toList();

  Job toJob() => Job(
        id: id,
        name: name,
        salary: salary,
        requirements: requirements
            .map((requirement) => Requirement.values.firstWhere((e) => e.toString() == requirement))
            .toList(),
      );
}
