import 'dart:convert';

import 'package:carambar/character/domain/entity/character.dart';
import 'package:carambar/character/domain/entity/nationality.dart';
import 'package:carambar/character/repository/entity/current_job_entity.dart';
import 'package:carambar/character/repository/entity/job_experience_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'character_entity.g.dart';

@JsonSerializable(nullable: true)
class CharacterEntity {
  final String firstName;
  final String lastName;
  final String gender;
  final String origin;
  final int age;
  final List<String> graduates;
  final CurrentJobEntity currentJob;
  final List<JobExperienceEntity> jobHistory;

  CharacterEntity({
    this.firstName,
    this.lastName,
    this.gender,
    this.origin,
    this.age,
    this.graduates,
    this.currentJob,
    this.jobHistory,
  });

  factory CharacterEntity.fromJson(String characterEntityJson) {
    final jsonData = json.decode(characterEntityJson);
    return _$CharacterEntityFromJson(jsonData);
  }

  Map<String, dynamic> toJson() => _$CharacterEntityToJson(this);

  CharacterEntity.fromCharacter(Character character)
      : firstName = character.firstName,
        lastName = character.lastName,
        gender = character.gender,
        origin = character.origin.toString(),
        age = character.age,
        graduates = character.graduates.map((graduate) => graduate.toString()).toList(),
        currentJob = character.currentJob != null ? CurrentJobEntity.fromCurrentJob(character.currentJob) : null,
        jobHistory = character.jobHistory != null
            ? character.jobHistory.map((jobExperience) => JobExperienceEntity.fromJobExperience(jobExperience)).toList()
            : null;

  Character toCharacter() {
    return Character(
      firstName: firstName,
      lastName: lastName,
      age: age,
      gender: gender,
      origin: Nationality.values.firstWhere((e) => e.toString() == origin),
      graduates: graduates.map((graduate) => Graduate.values.firstWhere((e) => e.toString() == graduate)).toList(),
      currentJob: currentJob?.toCurrentJob(),
      jobHistory: jobHistory != null ? jobHistory.map((jobExperience) => jobExperience.toJobExperience()).toList() : [],
    );
  }
}
