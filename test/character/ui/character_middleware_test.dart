import 'package:carambar/application/domain/entity/add_job_apply_failure_event.dart';
import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:carambar/application/domain/entity/initiate_event.dart';
import 'package:carambar/application/domain/entity/nationality.dart';
import 'package:carambar/application/domain/entity/set_current_job_event.dart';
import 'package:carambar/application/ui/application_actions.dart';
import 'package:carambar/character/ui/character_actions.dart';
import 'package:carambar/character/ui/character_middleware.dart';
import 'package:carambar/work/domain/entity/job.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

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

        verify(Mocks.store.dispatch(SetCharacterAction(character)));
        verify(Mocks.mockNext.next(initiateStateAction));
        verifyNever(Mocks.characterService.generateCharacter());
      });

      test('generates a character if none exists and stores it in the state', () async {
        var initiateStateAction = InitiateStateAction();
        var character = Factory.character();

        when(Mocks.characterService.getCharacter()).thenAnswer((_) async => null);
        when(Mocks.characterService.generateCharacter()).thenAnswer((_) async => character);

        await initiateCharacter(Mocks.store, initiateStateAction, Mocks.next);

        verify(Mocks.store.dispatch(SetCharacterAction(character)));
        verify(Mocks.mockNext.next(initiateStateAction));
      });

      test('generates a character if none exists and stores new game events', () async {
        final gameEvents = [InitiateEvent(
          0,
          'firstName',
          'lastName',
          'gender',
          Nationality.france,
        )];
        var initiateStateAction = InitiateStateAction();
        var character = Factory.character(age: 0);

        when(Mocks.characterService.getCharacter()).thenAnswer((_) async => null);
        when(Mocks.characterService.generateCharacter()).thenAnswer((_) async => character);
        when(Mocks.gameService.initiate(any)).thenAnswer((_) async => gameEvents);

        await initiateCharacter(Mocks.store, initiateStateAction, Mocks.next);

        verify(Mocks.gameService.initiate(character));
        verify(Mocks.store.dispatch(SetGameEventsAction(gameEvents)));
      });
    });

    group('setCharacterJob', () {
      test('calls the character service to set the current job and sets the state', () async {
        var job = Factory.job();
        var currentJob = Factory.currentJob();
        var expectedCharacter = Factory.character(currentJob: currentJob);
        var setCharacterJobAction = SetCharacterJobAction(job);

        when(Mocks.characterService.getUnmetRequirements(any)).thenAnswer((_) async => []);
        when(Mocks.characterService.setJob(any)).thenAnswer((_) async => expectedCharacter);

        await setCharacterJob(Mocks.store, setCharacterJobAction, Mocks.next);

        verify(Mocks.store.dispatch(SetCharacterAction(expectedCharacter)));
        verify(Mocks.characterService.setJob(job));
        verify(Mocks.mockNext.next(setCharacterJobAction));
      });

      test('adds an event with the started job', () async {
        var job = Factory.job();
        var currentJob = Factory.currentJob();
        var expectedCharacter = Factory.character(currentJob: currentJob);
        var setCharacterJobAction = SetCharacterJobAction(job);
        var gameEvents = [
          GameEvent(23),
          SetCurrentJobEvent(23, job.id),
        ];

        when(Mocks.characterService.getUnmetRequirements(any)).thenAnswer((_) async => []);
        when(Mocks.characterService.setJob(any)).thenAnswer((_) async => expectedCharacter);
        when(Mocks.gameService.setCurrentJob(any))
            .thenAnswer((_) async => gameEvents);

        await setCharacterJob(Mocks.store, setCharacterJobAction, Mocks.next);

        verify(Mocks.gameService.setCurrentJob(job));
        verify(Mocks.store.dispatch(SetGameEventsAction(gameEvents)));
        verify(Mocks.characterService.setJob(job));
        verify(Mocks.mockNext.next(setCharacterJobAction));
      });

      test('calls the service to check if the character meets all the requirements and adds an event', () async {
        var job = Factory.job(id: 23, requirements: Requirement.values);
        var setCharacterJobAction = SetCharacterJobAction(job);
        var gameEvents = [
          GameEvent(23),
          AddJobApplyFailureEvent(23, job.id, Requirement.values),
        ];

        when(Mocks.characterService.getUnmetRequirements(any))
            .thenAnswer((_) async => Requirement.values);
        when(Mocks.characterService.getCharacter())
            .thenAnswer((_) async => Factory.character(age: 34));
        when(Mocks.gameService.addJobApplyFailure(any, any))
            .thenAnswer((_) async => gameEvents);

        await setCharacterJob(Mocks.store, setCharacterJobAction, Mocks.next);

        verify(Mocks.characterService.getUnmetRequirements(job));
        verify(Mocks.gameService.addJobApplyFailure(job, Requirement.values));
        verify(Mocks.store.dispatch(SetGameEventsAction(gameEvents)));
        verify(Mocks.mockNext.next(setCharacterJobAction));

        verifyNever(Mocks.store.dispatch(SetCharacterJobAction(job)));
        verifyNever(Mocks.characterService.setJob(job));
      });
    });
  });
}
