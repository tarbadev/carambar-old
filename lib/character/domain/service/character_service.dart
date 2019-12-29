import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/character/domain/service/client/character_client.dart';
import 'package:carambar/work/domain/entity/job.dart';

class CharacterService {
  final CharacterClient _characterClient;

  CharacterService(this._characterClient);

  Future<Character> generateCharacter() async {
    var character = await _characterClient.generateCharacter();

    return character;
  }

  Future<List<Requirement>> getUnmetRequirements(Character character, Job job) async {
    for (final requirement in job.requirements) {
      switch (requirement) {
        case Requirement.HighSchool:
          if (!character.graduates.contains(School.HighSchool)) {
            return [Requirement.HighSchool];
          }
          break;
        case Requirement.Supervisor3Years:
          if (!_verifyJobHistoryRequirement(character, 'Supervisor', 3)) {
            return [Requirement.Supervisor3Years];
          }
          break;
        case Requirement.SubTeacher1Year:
          if (!_verifyJobHistoryRequirement(character, 'Substitute Teacher', 1)) {
            return [Requirement.SubTeacher1Year];
          }
          break;
        case Requirement.Teacher5Years:
          if (!_verifyJobHistoryRequirement(character, 'Teacher', 5)) {
            return [Requirement.Teacher5Years];
          }
          break;
        case Requirement.Counselor5Years:
          if (!_verifyJobHistoryRequirement(character, 'Counselor', 5)) {
            return [Requirement.Counselor5Years];
          }
          break;
        case Requirement.AssociateDirector5Years:
          if (!_verifyJobHistoryRequirement(character, 'Associate Director', 5)) {
            return [Requirement.AssociateDirector5Years];
          }
          break;
      }
    }

    return [];
  }

  bool _verifyJobHistoryRequirement(Character character, String jobName, int experience) {
    var jobExperience =
        character.jobHistory.firstWhere((jobExperience) => jobExperience.name == jobName, orElse: () => null);
    if (jobExperience == null || jobExperience.experience < experience) {
      return false;
    }

    return true;
  }
}
