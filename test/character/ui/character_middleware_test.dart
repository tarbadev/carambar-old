import 'package:carambar/application/domain/entity/add_job_apply_failure_event.dart';
import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/application/domain/entity/finish_studies_event.dart';
import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:carambar/application/domain/entity/graduate_event.dart';
import 'package:carambar/application/domain/entity/job_experience.dart';
import 'package:carambar/application/domain/entity/nationality.dart';
import 'package:carambar/application/domain/entity/set_current_job_event.dart';
import 'package:carambar/application/domain/entity/start_school_event.dart';
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

    test('initiateCharacter generates a character', () async {
      var gameEvents = [Factory.initiateEvent()];
      var initiateCharacterAction = InitiateCharacterAction();
      var character = Character.fromInitiateEvent(gameEvents[0]);

      when(Mocks.characterService.generateCharacter())
          .thenAnswer((_) async => character);
      when(Mocks.gameService.initiate(any)).thenAnswer((_) async => gameEvents);

      await initiateCharacter(Mocks.store, initiateCharacterAction, Mocks.next);

      verify(Mocks.gameService.initiate(character));
      verify(Mocks.store.dispatch(SetGameEventsAction(gameEvents)));
      verify(Mocks.mockNext.next(initiateCharacterAction));
    });

    group('buildCharacter', () {
      test('builds the existing character with no job history', () async {
        final jobs = [Factory.job(id: 2), Factory.job(id: 54, name: 'Teacher')];
        var gameEvents = [
          Factory.initiateEvent(),
          GameEvent(1),
          GameEvent(2),
          GameEvent(3),
          StartSchoolEvent(3, School.Kindergarten),
          GraduateEvent(6, School.MiddleSchool),
          GraduateEvent(16, School.HighSchool),
          GameEvent(17),
          GameEvent(18),
          FinishStudiesEvent(18),
          GameEvent(19),
          GameEvent(20),
          GameEvent(21),
          GameEvent(22),
          GameEvent(23),
          GameEvent(24),
        ];
        var buildCharacterAction = BuildCharacterAction(gameEvents);
        var character = Character(
          firstName: 'John',
          lastName: 'Doe',
          gender: 'Male',
          origin: Nationality.france,
          age: 24,
          graduates: [School.MiddleSchool, School.HighSchool],
          currentJob: null,
          jobHistory: [],
          school: School.None,
        );

        when(Mocks.workService.getAvailableJobs()).thenAnswer((_) => jobs);

        await buildCharacter(Mocks.store, buildCharacterAction, Mocks.next);

        verify(Mocks.store.dispatch(SetCharacterAction(character)));
        verify(Mocks.mockNext.next(buildCharacterAction));
      });

      test('builds the existing character with no school started', () async {
        var gameEvents = [
          Factory.initiateEvent(),
          GameEvent(1),
          GameEvent(2),
        ];
        var buildCharacterAction = BuildCharacterAction(gameEvents);
        var character = Character(
          firstName: 'John',
          lastName: 'Doe',
          gender: 'Male',
          origin: Nationality.france,
          age: 2,
          graduates: [],
          currentJob: null,
          jobHistory: [],
          school: School.None,
        );

        when(Mocks.workService.getAvailableJobs()).thenAnswer((_) => []);

        await buildCharacter(Mocks.store, buildCharacterAction, Mocks.next);

        verify(Mocks.store.dispatch(SetCharacterAction(character)));
        verify(Mocks.mockNext.next(buildCharacterAction));
      });

      test('builds the existing character and stores it in the state',
          () async {
        final jobs = [Factory.job(id: 2), Factory.job(id: 54, name: 'Teacher')];
        var gameEvents = [
          Factory.initiateEvent(),
          GameEvent(1),
          GameEvent(2),
          GameEvent(3),
          StartSchoolEvent(3, School.Kindergarten),
          GraduateEvent(6, School.MiddleSchool),
          GraduateEvent(16, School.HighSchool),
          SetCurrentJobEvent(16, 2),
          GameEvent(17),
          GameEvent(18),
          GameEvent(19),
          SetCurrentJobEvent(19, 54),
          GameEvent(20),
          GameEvent(21),
          GameEvent(22),
          GameEvent(23),
          GameEvent(24),
        ];
        var buildCharacterAction = BuildCharacterAction(gameEvents);
        var character = Character(
          firstName: 'John',
          lastName: 'Doe',
          gender: 'Male',
          origin: Nationality.france,
          age: 24,
          graduates: [School.MiddleSchool, School.HighSchool],
          currentJob: Factory.job(id: 54, name: 'Teacher'),
          jobHistory: [
            JobExperience(jobs[0].name, 3),
            JobExperience(jobs[1].name, 5),
          ],
          school: School.Kindergarten,
        );

        when(Mocks.workService.getAvailableJobs()).thenAnswer((_) => jobs);

        await buildCharacter(Mocks.store, buildCharacterAction, Mocks.next);

        verify(Mocks.store.dispatch(SetCharacterAction(character)));
        verify(Mocks.mockNext.next(buildCharacterAction));
      });
    });

    group('setCharacterJob', () {
      test('adds an event with the started job', () async {
        var job = Factory.job();
        var setCharacterJobAction = SetCharacterJobAction(job);
        var gameEvents = [
          GameEvent(23),
          SetCurrentJobEvent(23, job.id),
        ];
        var originalCharacter = Factory.character();

        when(Mocks.applicationState.character).thenReturn(originalCharacter);
        when(Mocks.characterService.getUnmetRequirements(any, any))
            .thenAnswer((_) async => []);
        when(Mocks.gameService.setCurrentJob(any))
            .thenAnswer((_) async => gameEvents);

        await setCharacterJob(Mocks.store, setCharacterJobAction, Mocks.next);

        verify(Mocks.characterService
            .getUnmetRequirements(originalCharacter, job));
        verify(Mocks.gameService.setCurrentJob(job));
        verify(Mocks.store.dispatch(SetGameEventsAction(gameEvents)));
        verify(Mocks.mockNext.next(setCharacterJobAction));
      });

      test(
          'calls the service to check if the character meets all the requirements and adds an event',
          () async {
        var job = Factory.job(id: 23, requirements: Requirement.values);
        var setCharacterJobAction = SetCharacterJobAction(job);
        var gameEvents = [
          GameEvent(23),
          AddJobApplyFailureEvent(23, job.id, Requirement.values),
        ];
        var originalCharacter = Factory.character();

        when(Mocks.applicationState.character).thenReturn(originalCharacter);
        when(Mocks.characterService.getUnmetRequirements(any, any))
            .thenAnswer((_) async => Requirement.values);
        when(Mocks.gameService.addJobApplyFailure(any, any))
            .thenAnswer((_) async => gameEvents);

        await setCharacterJob(Mocks.store, setCharacterJobAction, Mocks.next);

        verify(Mocks.characterService
            .getUnmetRequirements(originalCharacter, job));
        verify(Mocks.gameService.addJobApplyFailure(job, Requirement.values));
        verify(Mocks.store.dispatch(SetGameEventsAction(gameEvents)));
        verify(Mocks.mockNext.next(setCharacterJobAction));

        verifyNever(Mocks.store.dispatch(SetCharacterJobAction(job)));
      });
    });
  });
}
