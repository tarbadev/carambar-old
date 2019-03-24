import 'package:carambar/character/domain/entity/job_experience.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'job_experience_entity.g.dart';

@JsonSerializable(nullable: false)
class JobExperienceEntity extends Equatable {
  final String name;
  final int experience;

  JobExperienceEntity(this.name, this.experience) : super([name, experience]);

  factory JobExperienceEntity.fromJson(Map<String, dynamic> json) => _$JobExperienceEntityFromJson(json);

  Map<String, dynamic> toJson() => _$JobExperienceEntityToJson(this);

  factory JobExperienceEntity.fromJobExperience(JobExperience jobExperience) =>
      JobExperienceEntity(jobExperience.name, jobExperience.experience);

  JobExperience toJobExperience() => JobExperience(name: name, experience: experience);
}