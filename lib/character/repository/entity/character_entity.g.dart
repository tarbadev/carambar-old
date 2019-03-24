// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterEntity _$CharacterEntityFromJson(Map<String, dynamic> json) {
  return CharacterEntity(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      gender: json['gender'] as String,
      origin: json['origin'] as String,
      age: json['age'] as int,
      graduates: (json['graduates'] as List)?.map((e) => e as String)?.toList(),
      job: json['job'] == null
          ? null
          : JobEntity.fromJson(json['job'] as Map<String, dynamic>),
      jobHistory: (json['jobHistory'] as List)
          ?.map((e) => e == null
              ? null
              : JobExperienceEntity.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$CharacterEntityToJson(CharacterEntity instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'origin': instance.origin,
      'age': instance.age,
      'graduates': instance.graduates,
      'job': instance.job,
      'jobHistory': instance.jobHistory
    };
