// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_event_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameEventEntity _$GameEventEntityFromJson(Map<String, dynamic> json) {
  return GameEventEntity(
      json['age'] as int,
      _$enumDecodeNullable(_$EventTypeEnumMap, json['eventType']),
      json['event'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GameEventEntityToJson(GameEventEntity instance) =>
    <String, dynamic>{
      'age': instance.age,
      'eventType': _$EventTypeEnumMap[instance.eventType],
      'event': instance.event
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$EventTypeEnumMap = <EventType, dynamic>{
  EventType.Initiate: 'Initiate',
  EventType.IncrementAge: 'IncrementAge'
};
