import 'dart:convert';

import 'package:carambar/domain/entity/age_event.dart';

class AgeEventEntity {
  final int age;
  final List<String> events;

  AgeEventEntity({this.age, this.events});

  Map<String, dynamic> toJson() => {
        'age': age,
        'events': events,
      };

  AgeEventEntity.fromAgeEvent(AgeEvent ageEvent)
      : age = ageEvent.age,
        events = ageEvent.events;

  static fromJson(Map<String, dynamic> jsonData) => AgeEventEntity(
        age: jsonData['age'],
        events: List.from(jsonData['events']),
      );

  AgeEvent toAgeEvent() => AgeEvent(age: age, events: events);
}
