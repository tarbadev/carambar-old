// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_job_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentJobEntity _$CurrentJobEntityFromJson(Map<String, dynamic> json) {
  return CurrentJobEntity(json['id'] as int, json['name'] as String,
      (json['salary'] as num)?.toDouble());
}

Map<String, dynamic> _$CurrentJobEntityToJson(CurrentJobEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'salary': instance.salary
    };
