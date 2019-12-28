import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:carambar/application/domain/entity/initiate_event.dart';
import 'package:carambar/character/ui/entity/display_character.dart';
import 'package:equatable/equatable.dart';

class AgeEvent extends Equatable {
  final int age;
  final List<String> events;

  AgeEvent(this.age, {this.events});

  factory AgeEvent.fromAge(int age) {
    return AgeEvent(age, events: []);
  }

  @override
  List<Object> get props => [age, events];

  factory AgeEvent.fromInitiateEvent(InitiateEvent initiateEvent) {
    final character = Character.fromInitiateEvent(initiateEvent);
    final displayCharacter = DisplayCharacter.fromCharacter(character);
    final event = '''
      You just started your life!
      You're a baby ${displayCharacter.genderChild.toLowerCase()} named ${displayCharacter.name} from ${displayCharacter.origin}
      '''
        .split('\n')
        .map((line) => line.trim())
        .reduce((line1, line2) => line2.isNotEmpty ? '$line1\n$line2' : line1);
    return AgeEvent(initiateEvent.age, events: [event]);
  }

  factory AgeEvent.fromGameEvent(GameEvent event) => AgeEvent(event.age, events: List());

  @override
  String toString() {
    return "AgeEvent(age=$age, events=${events.toString()})";
  }

}