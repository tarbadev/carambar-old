import 'package:carambar/home/domain/entity/age_event.dart';
import 'package:json_annotation/json_annotation.dart';

part 'age_event_entity.g.dart';

@JsonSerializable(nullable: false)
class AgeEventEntity {
  final int age;
  final List<String> events;

  AgeEventEntity({this.age, this.events});
  factory AgeEventEntity.fromJson(Map<String, dynamic> json) => _$AgeEventEntityFromJson(json);
  Map<String, dynamic> toJson() => _$AgeEventEntityToJson(this);

  AgeEventEntity.fromAgeEvent(AgeEvent ageEvent)
      : age = ageEvent.age,
        events = ageEvent.events;

  AgeEvent toAgeEvent() => AgeEvent(age: age, events: events);
}
