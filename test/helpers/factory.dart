import 'package:carambar/character/domain/entity/character.dart';
import 'package:carambar/character/domain/entity/current_job.dart';
import 'package:carambar/character/domain/entity/job_experience.dart';
import 'package:carambar/character/domain/entity/nationality.dart';
import 'package:carambar/character/domain/service/client/character_client_response.dart';
import 'package:carambar/character/ui/entity/display_character.dart';
import 'package:carambar/character/ui/entity/display_current_job.dart';
import 'package:carambar/character/ui/entity/display_job_experience.dart';
import 'package:carambar/home/domain/entity/age_event.dart';
import 'package:carambar/home/ui/entity/display_age_event.dart';
import 'package:carambar/work/domain/entity/job.dart';
import 'package:carambar/work/ui/entity/display_job.dart';

abstract class Factory {
  static const List<Graduate> _factoryGraduates = [];

  static Character character(
      {int age: 18,
      List<Graduate> graduates: _factoryGraduates,
      CurrentJob currentJob,
      List<JobExperience> jobHistory: const []}) {
    return Character(
      firstName: 'john',
      lastName: 'doe',
      gender: 'male',
      age: age,
      origin: Nationality.unitedStates,
      graduates: graduates,
      currentJob: currentJob,
      jobHistory: jobHistory,
    );
  }

  static DisplayCharacter displayCharacter({
    age: '18',
    ageCategory: 'Adult',
    school: 'None',
    DisplayCurrentJob currentJob,
    List<DisplayJobExperience> jobHistory: const [],
  }) {
    return DisplayCharacter(
      'John Doe',
      'Male',
      age,
      'United States',
      ageCategory,
      school,
      [],
      currentJob,
      jobHistory,
    );
  }

  static CharacterClientModel characterClientModel() {
    return CharacterClientModel(
      gender: 'male',
      name: Name(
        title: 'mr',
        first: 'john',
        last: 'doe',
      ),
      email: 'imogen.johnson@example.com',
      nat: 'US',
      picture: Picture(
        large: 'https://randomuser.me/api/portraits/women/29.jpg',
        medium: 'https://randomuser.me/api/portraits/med/women/29.jpg',
        thumbnail: 'https://randomuser.me/api/portraits/thumb/women/29.jpg',
      ),
    );
  }

  static const List<String> _factoryEventList = ['Some event'];

  static AgeEvent ageEvent({int age: 0, List<String> events: _factoryEventList}) {
    return AgeEvent(age: age, events: events);
  }

  static DisplayAgeEvent displayAgeEvent({int id: 0, String age: 'Age 0', List<String> events: _factoryEventList}) {
    return DisplayAgeEvent(id, age, events);
  }

  static List<DisplayAgeEvent> ageEventsToDisplayAgeEvents(List<AgeEvent> ageEvents) =>
      ageEvents.map((ageEvent) => DisplayAgeEvent.fromAgeEvent(ageEvent)).toList();

  static const List<Requirement> _factoryRequirements = [Requirement.HighSchool];
  static const List<PersonalityTrait> _factoryPersonalityTraits = [PersonalityTrait.Charismatic];

  static Job job({
    int id: 1,
    List<Requirement> requirements: _factoryRequirements,
    List<PersonalityTrait> personalityTraits: _factoryPersonalityTraits,
  }) {
    return Job(
        id: id, name: 'Supervisor', salary: 15000, requirements: requirements, personalityTraits: personalityTraits);
  }

  static const List<String> _factoryDisplayRequirements = ['\u2022 High School completed successfully'];
  static const List<String> _factoryDisplayPersonalityTraits = ['\u2022 Charismatic'];

  static DisplayJob displayJob({
    String name: 'Supervisor',
    List<String> requirements: _factoryDisplayRequirements,
    String salary: '\$15,000/year',
    int id: 1,
    List<String> personalityTraits: _factoryDisplayPersonalityTraits,
  }) {
    return DisplayJob(id, name, requirements, salary, personalityTraits);
  }

  static JobExperience jobExperience({String name: 'Supervisor', int experience: 2}) {
    return JobExperience(name: name, experience: experience);
  }

  static DisplayJobExperience displayJobExperience({String name: 'Supervisor', String experience: '2 years'}) {
    return DisplayJobExperience(name: name, experience: experience);
  }

  static CurrentJob currentJob({
    int id: 1,
    String name: 'Supervisor',
    double salary: 15000,
  }) =>
      CurrentJob(
        id: id,
        name: name,
        salary: salary,
      );

  static DisplayCurrentJob displayCurrentJob() => DisplayCurrentJob(
        1,
        'Supervisor',
        '\$15,000/year',
      );
}
