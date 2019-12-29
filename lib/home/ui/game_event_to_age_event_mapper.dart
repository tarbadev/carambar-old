import 'package:carambar/application/domain/entity/add_cash_event.dart';
import 'package:carambar/application/domain/entity/add_job_apply_failure_event.dart';
import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/application/domain/entity/finish_studies_event.dart';
import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:carambar/application/domain/entity/graduate_event.dart';
import 'package:carambar/application/domain/entity/initiate_event.dart';
import 'package:carambar/application/domain/entity/set_current_job_event.dart';
import 'package:carambar/application/domain/entity/start_school_event.dart';
import 'package:carambar/application/repository/entity/game_event_entity.dart';
import 'package:carambar/home/domain/entity/age_event.dart';
import 'package:carambar/work/domain/entity/job.dart';
import 'package:carambar/work/domain/service/work_service.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class GameEventToAgeEventMapper {
  static List<AgeEvent> execute(List<GameEvent> events) {
    final ageEvents = List<AgeEvent>();
    final container = kiwi.Container();
    final _workService = container<WorkService>();

    final jobs = _workService.getAvailableJobs();

    events.forEach((event) {
      switch (event.runtimeType) {
        case InitiateEvent:
          ageEvents.add(AgeEvent.fromInitiateEvent(event));
          break;
        case GameEvent:
          ageEvents.add(AgeEvent.fromGameEvent(event));
          break;
        case AddJobApplyFailureEvent:
          AddJobApplyFailureEvent actualEvent =
              event as AddJobApplyFailureEvent;
          AgeEvent ageEvent = _getAgeEventForAge(ageEvents, event);

          ageEvent.events.add(
            'You failed to apply for this new job because you don\'t meet all the requirements:',
          );
          ageEvent.events.addAll(
            actualEvent.unmetRequirements.map((unmetRequirement) =>
                _requirementToDisplayUnmetRequirement[unmetRequirement]),
          );
          break;
        case FinishStudiesEvent:
          AgeEvent ageEvent = _getAgeEventForAge(ageEvents, event);
          ageEvent.events.add('You finished your studies');
          break;
        case GraduateEvent:
          final actualEvent = event as GraduateEvent;
          final ageEvent = _getAgeEventForAge(ageEvents, event);
          ageEvent.events.add(
              'You graduated from ${_mapSchoolToDisplaySchool[actualEvent.school]}');
          break;
        case SetCurrentJobEvent:
          SetCurrentJobEvent actualEvent = event as SetCurrentJobEvent;
          AgeEvent ageEvent = _getAgeEventForAge(ageEvents, event);

          final job = jobs.firstWhere((job) => job.id == actualEvent.jobId);
          ageEvent.events.add('You\'re now a ${job.name}');
          break;
        case StartSchoolEvent:
          final ageEvent = _getAgeEventForAge(ageEvents, event);
          final actualEvent = event as StartSchoolEvent;
          ageEvent.events.add('You just started ${_mapSchoolToDisplaySchool[actualEvent.school]}');
          break;
        case AddCashEvent:
          break;
        default:
          throw GameEventTypeNotKnownException(event.runtimeType);
      }
    });

    return ageEvents;
  }

  static AgeEvent _getAgeEventForAge(List ageEvents, GameEvent event) {
    return ageEvents.firstWhere(
      (existingAgeEvent) => existingAgeEvent.age == event.age,
    );
  }

  static final Map<Requirement, String> _requirementToDisplayUnmetRequirement =
      {
    Requirement.HighSchool: '\u2022 Did not graduate from High School',
    Requirement.Supervisor3Years:
        '\u2022 Does not have at least 3 years of experience as a Supervisor',
    Requirement.SubTeacher1Year:
        '\u2022 Does not have at least 1 year of experience as a Substitute Teacher',
    Requirement.Teacher5Years:
        '\u2022 Does not have at least 5 years of experience as a Teacher',
    Requirement.Counselor5Years:
        '\u2022 Does not have at least 5 years of experience as a Counselor',
    Requirement.AssociateDirector5Years:
        '\u2022 Does not have at least 5 years of experience as a Associate Director',
  };

  static final _mapSchoolToDisplaySchool = {
    School.None: 'None',
    School.Kindergarten: 'Kindergarten',
    School.PrimarySchool: 'Primary School',
    School.MiddleSchool: 'Middle School',
    School.HighSchool: 'High School',
  };
}
