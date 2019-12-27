import 'package:carambar/application/ui/application_actions.dart';
import 'package:carambar/character/ui/character_actions.dart';
import 'package:carambar/character/ui/character_middleware.dart';
import 'package:carambar/character/ui/entity/display_character.dart';
import 'package:carambar/home/ui/home_actions.dart';
import 'package:carambar/work/domain/entity/job.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/factory.dart';
import '../../helpers/fake_application_injector.dart';
import '../../helpers/mock_definition.dart';

void main() {
  setupDependencyInjectorForTest();

  group('Character Middleware', () {
    setUp(() {
      Mocks.setupMockStore();
    });

    group('initiateCharacter', () {
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
        var line2 =
            'You\'re a baby ${displayCharacter.genderChild.toLowerCase()} named ${displayCharacter.name} from ${displayCharacter.origin}';
        var expectedEvent = '$line1\n$line2';
        var ageEvents = [
          Factory.ageEvent(age: 0, events: [expectedEvent])
        ];

        when(Mocks.characterService.getCharacter()).thenAnswer((_) async => null);
        when(Mocks.characterService.generateCharacter()).thenAnswer((_) async => character);
        when(Mocks.ageEventService.addEvent(any, event: anyNamed('event'))).thenAnswer((_) async => ageEvents);

        await initiateCharacter(Mocks.store, initiateStateAction, Mocks.next);

        verify(Mocks.ageEventService.addEvent(0, event: expectedEvent));
        verify(Mocks.store.dispatch(SetAgeEventsAction(Factory.ageEventsToDisplayAgeEvents(ageEvents))));
      });
    });

    group('setCharacterJob', () {
      test('calls the character service to set the current job and sets the state', () async {
        var job = Factory.job();
        var currentJob = Factory.currentJob();
        var expectedCharacter = Factory.character(currentJob: currentJob);
        var expectedDisplayCharacter = Factory.displayCharacter(currentJob: Factory.displayCurrentJob());
        var setCharacterJobAction = SetCharacterJobAction(job);

        when(Mocks.characterService.getUnmetRequirements(any)).thenAnswer((_) async => []);
        when(Mocks.characterService.setJob(any)).thenAnswer((_) async => expectedCharacter);
        when(Mocks.ageEventService.addEvents(any, any)).thenAnswer((_) async => []);

        await setCharacterJob(Mocks.store, setCharacterJobAction, Mocks.next);

        verify(Mocks.store.dispatch(SetCharacterAction(expectedDisplayCharacter)));
        verify(Mocks.characterService.setJob(job));
        verify(Mocks.mockNext.next(setCharacterJobAction));
      });

      test('adds an event with the started job', () async {
        var job = Factory.job();
        var currentJob = Factory.currentJob();
        var expectedCharacter = Factory.character(currentJob: currentJob);
        var setCharacterJobAction = SetCharacterJobAction(job);
        var ageEvents = [
          Factory.ageEvent(age: 34, events: ['You\'re now a Supervisor'])
        ];

        when(Mocks.characterService.getUnmetRequirements(any)).thenAnswer((_) async => []);
        when(Mocks.characterService.setJob(any)).thenAnswer((_) async => expectedCharacter);
        when(Mocks.ageEventService.addEvents(any, any)).thenAnswer((_) async => ageEvents);

        await setCharacterJob(Mocks.store, setCharacterJobAction, Mocks.next);

        verify(Mocks.store.dispatch(SetAgeEventsAction(Factory.ageEventsToDisplayAgeEvents(ageEvents))));
        verify(Mocks.characterService.setJob(job));
        verify(Mocks.mockNext.next(setCharacterJobAction));
      });

      test('calls the service to check if the character meets all the requirements and adds an event', () async {
        var job = Factory.job(id: 23, requirements: Requirement.values);
        var setCharacterJobAction = SetCharacterJobAction(job);
        var expectedEvents = [
          'You failed to apply for this new job because you don\'t meet all the requirements:',
          '\u2022 Did not graduate from High School',
          '\u2022 Does not have at least 3 years of experience as a Supervisor',
          '\u2022 Does not have at least 1 year of experience as a Substitute Teacher',
          '\u2022 Does not have at least 5 years of experience as a Teacher',
          '\u2022 Does not have at least 5 years of experience as a Counselor',
          '\u2022 Does not have at least 5 years of experience as a Associate Director',
        ];
        var ageEvents = [
          Factory.ageEvent(age: 34, events: expectedEvents)
        ];

        when(Mocks.characterService.getUnmetRequirements(any))
            .thenAnswer((_) async => Requirement.values);
        when(Mocks.characterService.getCharacter())
            .thenAnswer((_) async => Factory.character(age: 34));
        when(Mocks.ageEventService.addEvents(any, any))
            .thenAnswer((_) async => ageEvents);

        await setCharacterJob(Mocks.store, setCharacterJobAction, Mocks.next);

        verify(Mocks.characterService.getUnmetRequirements(job));
        verify(Mocks.ageEventService.addEvents(34, expectedEvents));
        verify(Mocks.store.dispatch(SetAgeEventsAction(Factory.ageEventsToDisplayAgeEvents(ageEvents))));
        verify(Mocks.mockNext.next(setCharacterJobAction));

        verifyNever(Mocks.store.dispatch(SetCharacterJobAction(job)));
        verifyNever(Mocks.characterService.setJob(job));
      });
    });
  });
}
