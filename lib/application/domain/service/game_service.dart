import 'package:carambar/application/domain/entity/finish_studies_event.dart';
import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/application/domain/entity/graduate_event.dart';
import 'package:carambar/application/domain/entity/increment_job_experience_event.dart';
import 'package:carambar/application/domain/entity/initiate_event.dart';
import 'package:carambar/application/domain/entity/start_school_event.dart';
import 'package:carambar/application/repository/game_repository.dart';

class GameService {
  final GameRepository gameRepository;

  GameService(this.gameRepository);

  Future initiate(Character character) async {
    await gameRepository.save([InitiateEvent.fromCharacter(character)]);
  }

  Future incrementAge() async {
    List<GameEvent> events = await gameRepository.readEvents();
    events.add(GameEvent(events.last.age + 1));
    await gameRepository.save(events);
  }

  Future finishStudies() async {
    List<GameEvent> events = await gameRepository.readEvents();
    events.add(FinishStudiesEvent(events.last.age));
    await gameRepository.save(events);
  }

  Future startSchool(School school) async {
    List<GameEvent> events = await gameRepository.readEvents();
    events.add(StartSchoolEvent(events.last.age, school));
    await gameRepository.save(events);
  }

  Future graduate(School school) async {
    List<GameEvent> events = await gameRepository.readEvents();
    events.add(GraduateEvent(events.last.age, school));
    await gameRepository.save(events);
  }

  Future incrementJobExperience() async {
    List<GameEvent> events = await gameRepository.readEvents();
    events.add(IncrementJobExperienceEvent(events.last.age));
    await gameRepository.save(events);
  }
}