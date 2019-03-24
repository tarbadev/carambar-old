// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'age_event_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgeEventEntity _$AgeEventEntityFromJson(Map<String, dynamic> json) {
  return AgeEventEntity(
      age: json['age'] as int,
      events: (json['events'] as List).map((e) => e as String).toList());
}

Map<String, dynamic> _$AgeEventEntityToJson(AgeEventEntity instance) =>
    <String, dynamic>{'age': instance.age, 'events': instance.events};
