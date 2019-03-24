import 'package:carambar/character/domain/entity/character.dart';
import 'package:carambar/character/domain/entity/job_experience.dart';
import 'package:carambar/character/domain/service/client/character_client.dart';
import 'package:carambar/character/repository/character_repository.dart';
import 'package:carambar/work/domain/entity/job.dart';

class CharacterService {
  final CharacterRepository _characterRepository;
  final CharacterClient _characterClient;

  CharacterService(this._characterRepository, this._characterClient);

  Future<Character> getCharacter() async {
    return await _characterRepository.readCharacter();
  }

  Future<Character> incrementAge() async {
    Character character = await _characterRepository.readCharacter();
    character.age++;

    await _characterRepository.save(character);

    return character;
  }

  Future<Character> generateCharacter() async {
    var character = await _characterClient.generateCharacter();
    character.age = 0;

    await _characterRepository.save(character);

    return character;
  }

  Future<void> deleteCharacter() async => await _characterRepository.delete();

  Future<Character> addGraduate(Graduate graduate) async {
    Character character = await _characterRepository.readCharacter();
    character.graduates.add(graduate);

    await _characterRepository.save(character);

    return character;
  }

  Future<Character> setJob(Job job) async {
    Character character = await _characterRepository.readCharacter();
    character.jobHistory.add(JobExperience(name: job.name, experience: 0));

    character = Character(
      firstName: character.firstName,
      lastName: character.lastName,
      age: character.age,
      origin: character.origin,
      gender: character.gender,
      graduates: character.graduates,
      job: job,
      jobHistory: character.jobHistory,
    );

    await _characterRepository.save(character);

    return character;
  }

  Future<bool> areRequirementsMet(Job job) async {
    Character character = await _characterRepository.readCharacter();

    for (final requirement in job.requirements) {
      switch (requirement) {
        case Requirement.HighSchool:
          if (!character.graduates.contains(Graduate.HighSchool)) {
            return false;
          }
          break;
        case Requirement.Supervisor3Years:
          var jobExperience = character.jobHistory
              .firstWhere((jobExperience) => jobExperience.name == 'Supervisor', orElse: () => null);
          if (jobExperience == null || jobExperience.experience < 3) {
            return false;
          }
          break;
        case Requirement.Teacher5Years:
          var jobExperience = character.jobHistory
              .firstWhere((jobExperience) => jobExperience.name == 'Teacher', orElse: () => null);
          if (jobExperience == null || jobExperience.experience < 5) {
            return false;
          }
          break;
        default:
          return false;
      }
    }

    return true;
  }

  Future<Character> incrementJobExperience() async {
    Character character = await _characterRepository.readCharacter();

    var currentJobExperience = character.jobHistory[character.jobHistory.length - 1];
    character.jobHistory[character.jobHistory.length - 1] = JobExperience(
      name: currentJobExperience.name,
      experience: currentJobExperience.experience + 1,
    );

    await _characterRepository.save(character);

    return character;
  }
}
