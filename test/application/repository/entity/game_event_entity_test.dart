import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:carambar/application/repository/entity/game_event_entity.dart';
import 'package:test/test.dart';

void main() {
  group('GameEventEntity', () {
    group('fromEvent', () {
      test('throws an exception when the type is not known', () {
        expect(
          () => GameEventEntity.fromEvent(TestGameEvent(10)),
          throwsA(TypeMatcher<GameEventTypeNotKnownException>()),
        );
      });
    });

    group('toEvent', () {
      test('throws an exception when the type is not known', () {
        expect(
          () => GameEventEntity(10, null, null).toEvent(),
          throwsA(TypeMatcher<GameEventTypeNotKnownException>()),
        );
      });
    });
  });
}

class TestGameEvent extends GameEvent {
  TestGameEvent(int age) : super(age);
}
