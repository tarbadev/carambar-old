import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:carambar/application/domain/entity/initiate_event.dart';
import 'package:carambar/application/domain/entity/nationality.dart';
import 'package:carambar/home/domain/entity/age_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AgeEvent', () {
    test('fromInitiateEvent', () {
      final event = InitiateEvent(0, 'John', 'Doe', 'Male', Nationality.france);
      var line1 = 'You just started your life!';
      var line2 = 'You\'re a baby boy named John Doe from France';
      var expectedEvent = '$line1\n$line2';
      final ageEvent = AgeEvent(0, events: [expectedEvent]);
      expect(AgeEvent.fromInitiateEvent(event), ageEvent);
    });

    test('fromGameEvent', () {
      final event = GameEvent(12);
      final ageEvent = AgeEvent(12, events: []);
      expect(AgeEvent.fromGameEvent(event), ageEvent);
    });
  });
}
