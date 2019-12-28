import 'package:carambar/application/domain/entity/add_cash_event.dart';
import 'package:carambar/application/domain/entity/add_job_apply_failure_event.dart';
import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/application/domain/entity/finish_studies_event.dart';
import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:carambar/application/domain/entity/graduate_event.dart';
import 'package:carambar/application/domain/entity/increment_job_experience_event.dart';
import 'package:carambar/application/domain/entity/initiate_event.dart';
import 'package:carambar/application/domain/entity/set_current_job_event.dart';
import 'package:carambar/application/domain/entity/start_school_event.dart';
import 'package:carambar/application/repository/game_repository.dart';
import 'package:carambar/work/domain/entity/job.dart';

class GameService {
  final GameRepository gameRepository;

  GameService(this.gameRepository);

  Future<List<GameEvent>> initiate(Character character) async {
    return await gameRepository.save([InitiateEvent.fromCharacter(character)]);
  }

  Future<List<GameEvent>> incrementAge() async {
    List<GameEvent> events = await gameRepository.readEvents();
    events.add(GameEvent(events.last.age + 1));
    return await gameRepository.save(events);
  }

  Future<List<GameEvent>> finishStudies() async {
    List<GameEvent> events = await gameRepository.readEvents();
    events.add(FinishStudiesEvent(events.last.age));
    return await gameRepository.save(events);
  }

  Future<List<GameEvent>> startSchool(School school) async {
    List<GameEvent> events = await gameRepository.readEvents();
    events.add(StartSchoolEvent(events.last.age, school));
    return await gameRepository.save(events);
  }

  Future<List<GameEvent>> graduate(School school) async {
    List<GameEvent> events = await gameRepository.readEvents();
    events.add(GraduateEvent(events.last.age, school));
    return await gameRepository.save(events);
  }

  Future<List<GameEvent>> incrementJobExperience() async {
    List<GameEvent> events = await gameRepository.readEvents();
    events.add(IncrementJobExperienceEvent(events.last.age));
    return await gameRepository.save(events);
  }

  Future<List<GameEvent>> addCash(double cashToAdd) async {
    List<GameEvent> events = await gameRepository.readEvents();
    events.add(AddCashEvent(events.last.age, cashToAdd));
    return await gameRepository.save(events);
  }

  Future<List<GameEvent>> setCurrentJob(Job job) async {
    List<GameEvent> events = await gameRepository.readEvents();
    events.add(SetCurrentJobEvent(events.last.age, job.id));
    return await gameRepository.save(events);
  }

  Future<List<GameEvent>> addJobApplyFailure(Job job, List<Requirement> unMetRequirements) async {
    List<GameEvent> events = await gameRepository.readEvents();
    events.add(AddJobApplyFailureEvent(events.last.age, job.id, unMetRequirements));
    return await gameRepository.save(events);
  }

  Future<List<GameEvent>> getEvents() async {
    return await gameRepository.readEvents() ?? [];
  }

  Future deleteGameEvents() async => await gameRepository.delete();
}