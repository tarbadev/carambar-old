import 'package:carambar/home/domain/entity/age_event.dart';
import 'package:equatable/equatable.dart';

class DisplayAgeEvent extends Equatable {
  final int id;
  final String age;
  final List<String> events;

  DisplayAgeEvent(this.id, this.age, this.events);

  static DisplayAgeEvent fromAgeEvent(AgeEvent ageEvent) =>
      DisplayAgeEvent(ageEvent.age, 'Age ${ageEvent.age}', ageEvent.events);

  @override
  List<Object> get props => [id, age, events];
}
