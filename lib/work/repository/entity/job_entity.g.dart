// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobEntity _$JobEntityFromJson(Map<String, dynamic> json) {
  return JobEntity(
      id: json['id'] as int,
      name: json['name'] as String,
      salary: (json['salary'] as num).toDouble(),
      requirements:
          (json['requirements'] as List).map((e) => e as String).toList(),
      personalityTraits:
          (json['personalityTraits'] as List).map((e) => e as String).toList());
}

Map<String, dynamic> _$JobEntityToJson(JobEntity instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'salary': instance.salary,
      'requirements': instance.requirements,
      'personalityTraits': instance.personalityTraits
    };
