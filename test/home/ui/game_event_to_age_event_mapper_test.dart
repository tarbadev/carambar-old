import 'package:carambar/application/domain/entity/add_cash_event.dart';
import 'package:carambar/application/domain/entity/add_job_apply_failure_event.dart';
import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/application/domain/entity/finish_studies_event.dart';
import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:carambar/application/domain/entity/graduate_event.dart';
import 'package:carambar/application/domain/entity/increment_job_experience_event.dart';
import 'package:carambar/application/domain/entity/initiate_event.dart';
import 'package:carambar/application/domain/entity/nationality.dart';
import 'package:carambar/application/domain/entity/set_current_job_event.dart';
import 'package:carambar/application/domain/entity/start_school_event.dart';
import 'package:carambar/application/repository/entity/game_event_entity.dart';
import 'package:carambar/home/domain/entity/age_event.dart';
import 'package:carambar/home/ui/game_event_to_age_event_mapper.dart';
import 'package:carambar/work/domain/entity/job.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../helpers/factory.dart';
import '../../helpers/fake_application_injector.dart';
import '../../helpers/mock_definition.dart';

void main() {
  setupDependencyInjectorForTest();

  group('GameEventToAgeEventMapper', () {
    test('convert GameEvent', () {
      final event = GameEvent(18);
      final ageEvents = [AgeEvent(18, events: [])];

      expect(GameEventToAgeEventMapper.execute([event]), ageEvents);
    });

    test('convert InitiateEvent', () {
      final event = InitiateEvent(0, 'John', 'Doe', 'Male', Nationality.france);
      var line1 = 'You just started your life!';
      var line2 = 'You\'re a baby boy named John Doe from France';
      var expectedEvent = '$line1\n$line2';
      final ageEvents = [
        AgeEvent(0, events: [expectedEvent])
      ];

      expect(GameEventToAgeEventMapper.execute([event]), ageEvents);
    });

    test('convert AddJobApplyFailureEvent', () {
      final event = AddJobApplyFailureEvent(20, 2, Requirement.values);
      final expectedEvents = [
        'You failed to apply for this new job because you don\'t meet all the requirements:',
        '\u2022 Did not graduate from High School',
        '\u2022 Does not have at least 3 years of experience as a Supervisor',
        '\u2022 Does not have at least 1 year of experience as a Substitute Teacher',
        '\u2022 Does not have at least 5 years of experience as a Teacher',
        '\u2022 Does not have at least 5 years of experience as a Counselor',
        '\u2022 Does not have at least 5 years of experience as a Associate Director',
      ];
      final ageEvents = [AgeEvent(20, events: expectedEvents)];

      expect(GameEventToAgeEventMapper.execute([GameEvent(20), event]), ageEvents);
    });

    test('convert FinishStudiesEvent', () {
      final event = FinishStudiesEvent(20);
      final ageEvents = [AgeEvent(20, events: ['You finished your studies'])];

      expect(GameEventToAgeEventMapper.execute([GameEvent(20), event]), ageEvents);
    });

    test('convert GraduateEvent', () {
      final event = GraduateEvent(20, School.MiddleSchool);
      final ageEvents = [AgeEvent(20, events: ['You graduated from Middle School'])];

      expect(GameEventToAgeEventMapper.execute([GameEvent(20), event]), ageEvents);
    });

    test('convert SetCurrentJobEvent', () {
      final job = Factory.job(id: 2);
      final event = SetCurrentJobEvent(20, job.id);
      final ageEvents = [AgeEvent(20, events: ['You\'re now a ${job.name}'])];

      when(Mocks.workService.getAvailableJobs()).thenAnswer((_) => [job]);

      expect(GameEventToAgeEventMapper.execute([GameEvent(20), event]), ageEvents);
    });

    test('convert StartSchoolEvent', () {
      final event = StartSchoolEvent(20, School.HighSchool);
      final ageEvents = [AgeEvent(20, events: ['You just started High School'])];

      expect(GameEventToAgeEventMapper.execute([GameEvent(20), event]), ageEvents);
    });

    test('ignore AddCashEvent', () {
      final event = AddCashEvent(20, 20.0);
      final ageEvents = [];

      expect(GameEventToAgeEventMapper.execute([event]), ageEvents);
    });

    test('ignore IncrementJobExperienceEvent', () {
      final event = IncrementJobExperienceEvent(20);
      final ageEvents = [];

      expect(GameEventToAgeEventMapper.execute([event]), ageEvents);
    });

    test('Throws GameEventTypeNotKnownException for any non known type', () {
      final event = TestGameEvent(20);

      expect(
        () => GameEventToAgeEventMapper.execute([event]),
        throwsA(TypeMatcher<GameEventTypeNotKnownException>()),
      );
    });
  });
}
