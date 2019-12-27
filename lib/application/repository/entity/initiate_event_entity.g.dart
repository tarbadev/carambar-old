// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initiate_event_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InitiateEventEntity _$InitiateEventEntityFromJson(Map<String, dynamic> json) {
  return InitiateEventEntity(
      json['age'] as int,
      json['firstName'] as String,
      json['lastName'] as String,
      json['gender'] as String,
      json['origin'] as String);
}

Map<String, dynamic> _$InitiateEventEntityToJson(
        InitiateEventEntity instance) =>
    <String, dynamic>{
      'age': instance.age,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'origin': instance.origin
    };
