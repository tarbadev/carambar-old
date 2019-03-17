import 'package:carambar/application/ui/application_actions.dart';
import 'package:carambar/character/ui/character_actions.dart';
import 'package:carambar/character/ui/character_middleware.dart';
import 'package:carambar/character/ui/entity/display_character.dart';
import 'package:carambar/home/ui/home_actions.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

import '../../helpers/factory.dart';
import '../../helpers/fake_application_injector.dart';
import '../../helpers/mock_definition.dart';

void main() {
  setupDependencyInjectorForTest();

  group("Character Middleware", () {
    setUp(() {
      Mocks.setupMockStore();
    });

    group("initiateCharacter", () {
      test('retrieves the existing character and stores it in the state', () async {
        var initiateStateAction = InitiateStateAction();
        var character = Factory.character();

        when(Mocks.characterService.getCharacter()).thenAnswer((_) async => character);

        await initiateCharacter(Mocks.store, initiateStateAction, Mocks.next);

        verify(Mocks.store.dispatch(SetCharacterAction(DisplayCharacter.fromCharacter(character))));
        verify(Mocks.mockNext.next(initiateStateAction));
        verifyNever(Mocks.characterService.generateCharacter());
      });

      test('generates a character if none exists and stores it in the state', () async {
        var initiateStateAction = InitiateStateAction();
        var character = Factory.character();
        var ageEvents = [Factory.ageEvent(age: 18, events: [])];

        when(Mocks.characterService.getCharacter()).thenAnswer((_) async => null);
        when(Mocks.characterService.generateCharacter()).thenAnswer((_) async => character);
        when(Mocks.ageEventService.addEvent(any, event: anyNamed('event'))).thenAnswer((_) async => ageEvents);

        await initiateCharacter(Mocks.store, initiateStateAction, Mocks.next);

        verify(Mocks.store.dispatch(SetCharacterAction(DisplayCharacter.fromCharacter(character))));
        verify(Mocks.mockNext.next(initiateStateAction));
      });

      test('generates a character if none exists and adds an event', () async {
        var initiateStateAction = InitiateStateAction();
        var character = Factory.character(age: 0);
        var displayCharacter = DisplayCharacter.fromCharacter(character);
        var line1 = 'You just started your life!';
        var line2 = 'You\'re a baby ${displayCharacter.genderChild.toLowerCase()} named ${displayCharacter.name} from ${displayCharacter.origin}';
        var expectedEvent = '$line1\n$line2';
        var ageEvents = [Factory.ageEvent(age: 0, events: [expectedEvent])];

        when(Mocks.characterService.getCharacter()).thenAnswer((_) async => null);
        when(Mocks.characterService.generateCharacter()).thenAnswer((_) async => character);
        when(Mocks.ageEventService.addEvent(any, event: anyNamed('event'))).thenAnswer((_) async => ageEvents);

        await initiateCharacter(Mocks.store, initiateStateAction, Mocks.next);

        verify(Mocks.ageEventService.addEvent(0, event: expectedEvent));
        verify(Mocks.store.dispatch(SetAgeEventsAction(Factory.ageEventsToDisplayAgeEvents(ageEvents))));
      });
    });
  });
}
