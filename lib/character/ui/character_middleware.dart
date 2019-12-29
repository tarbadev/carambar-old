import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/application/domain/entity/finish_studies_event.dart';
import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:carambar/application/domain/entity/graduate_event.dart';
import 'package:carambar/application/domain/entity/initiate_event.dart';
import 'package:carambar/application/domain/entity/job_experience.dart';
import 'package:carambar/application/domain/entity/set_current_job_event.dart';
import 'package:carambar/application/domain/entity/start_school_event.dart';
import 'package:carambar/application/domain/service/game_service.dart';
import 'package:carambar/application/ui/application_actions.dart';
import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/character/domain/service/character_service.dart';
import 'package:carambar/character/ui/character_actions.dart';
import 'package:carambar/work/domain/entity/job.dart';
import 'package:carambar/work/domain/service/work_service.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:redux/redux.dart';

List<Middleware<ApplicationState>> createCharacterMiddleware() => [
      TypedMiddleware<ApplicationState, InitiateCharacterAction>(initiateCharacter),
      TypedMiddleware<ApplicationState, BuildCharacterAction>(buildCharacter),
      TypedMiddleware<ApplicationState, SetCharacterJobAction>(setCharacterJob),
    ];

Future initiateCharacter(Store<ApplicationState> store,
    InitiateCharacterAction action, NextDispatcher next) async {
  final container = kiwi.Container();
  final _gameService = container.resolve<GameService>();
  final _characterService = container.resolve<CharacterService>();

  final character = await _characterService.generateCharacter();
  final gameEvents = await _gameService.initiate(character);

  store.dispatch(SetGameEventsAction(gameEvents));

  next(action);
}

Future buildCharacter(Store<ApplicationState> store,
    BuildCharacterAction action, NextDispatcher next) async {
  final gameEvents = action.gameEvents;

  final initiateEvent = gameEvents[0] as InitiateEvent;
  final character = Character(
    age: gameEvents.last.age,
    firstName: initiateEvent.firstName,
    lastName: initiateEvent.lastName,
    gender: initiateEvent.gender,
    origin: initiateEvent.origin,
    graduates: _getGraduatesFromGameEvents(gameEvents),
    jobHistory: _getJobHistory(gameEvents),
    currentJob: _getCurrentJob(gameEvents),
    school: _getSchool(gameEvents),
  );

  store.dispatch(SetCharacterAction(character));

  next(action);
}

School _getSchool(List<GameEvent> gameEvents) {
  if (gameEvents
          .lastIndexWhere((event) => event.runtimeType == FinishStudiesEvent) >=
      0) {
    return School.None;
  }
  StartSchoolEvent lastSchoolEvent = gameEvents.lastWhere(
    (event) => event.runtimeType == StartSchoolEvent,
    orElse: () => null,
  );
  return lastSchoolEvent?.school ?? School.None;
}

List<JobExperience> _getJobHistory(List<GameEvent> gameEvents) {
  final setJobEvents = gameEvents
      .where((event) => event.runtimeType == SetCurrentJobEvent)
      .toList();

  if (setJobEvents.isEmpty) {
    return [];
  }

  final jobHistory = List<JobExperience>();

  for (int i = 0; i < setJobEvents.length; i++) {
    if (i <= (setJobEvents.length - 1) && i > 0) {
      final jobExperience = _buildJobExperience(
        setJobEvents[i - 1] as SetCurrentJobEvent,
        setJobEvents[i].age,
      );

      jobHistory.add(jobExperience);
    }
  }

  final lastJobExperience = _buildJobExperience(
    setJobEvents[setJobEvents.length - 1] as SetCurrentJobEvent,
    gameEvents.last.age,
  );

  jobHistory.add(lastJobExperience);

  return jobHistory;
}

JobExperience _buildJobExperience(
    SetCurrentJobEvent jobEvent, int ageAtLastEvent) {
  final container = kiwi.Container();
  final _workService = container.resolve<WorkService>();
  final jobs = _workService.getAvailableJobs();
  final ageAtLastJob = jobEvent.age;

  final previousJob = jobs.firstWhere((job) => job.id == jobEvent.jobId);
  return JobExperience(previousJob.name, ageAtLastEvent - ageAtLastJob);
}

List<School> _getGraduatesFromGameEvents(List<GameEvent> gameEvents) {
  return gameEvents
      .where((event) => event.runtimeType == GraduateEvent)
      .map((event) => (event as GraduateEvent).school)
      .toList();
}

Job _getCurrentJob(List<GameEvent> gameEvents) {
  final event = gameEvents.lastWhere(
    (event) => event.runtimeType == SetCurrentJobEvent,
    orElse: () => null,
  );

  if (event == null) {
    return null;
  }

  final container = kiwi.Container();
  final _workService = container.resolve<WorkService>();
  final jobs = _workService.getAvailableJobs();

  return jobs
      .firstWhere((job) => job.id == (event as SetCurrentJobEvent).jobId);
}

Future setCharacterJob(Store<ApplicationState> store,
    SetCharacterJobAction action, NextDispatcher next) async {
  var container = kiwi.Container();
  CharacterService _characterService = container.resolve<CharacterService>();
  GameService _gameService = container.resolve<GameService>();

  var gameEvents;
  var unmetRequirements = await _characterService.getUnmetRequirements(
    store.state.character,
    action.job,
  );

  if (unmetRequirements.isEmpty) {
    gameEvents = await _gameService.setCurrentJob(action.job);
  } else {
    gameEvents =
        await _gameService.addJobApplyFailure(action.job, unmetRequirements);
  }

  store.dispatch(SetGameEventsAction(gameEvents));

  next(action);
}
