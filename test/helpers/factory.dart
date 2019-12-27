import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/application/domain/entity/job_experience.dart';
import 'package:carambar/application/domain/entity/current_job.dart';
import 'package:carambar/application/domain/entity/nationality.dart';
import 'package:carambar/character/domain/service/client/character_client_response.dart';
import 'package:carambar/character/ui/entity/display_character.dart';
import 'package:carambar/character/ui/entity/display_current_job.dart';
import 'package:carambar/character/ui/entity/display_job_experience.dart';
import 'package:carambar/home/domain/entity/age_event.dart';
import 'package:carambar/home/ui/entity/display_age_event.dart';
import 'package:carambar/work/domain/entity/job.dart';
import 'package:carambar/work/ui/entity/display_job.dart';

abstract class Factory {
  static Character character(
      {int age: 18,
      List<Graduate> graduates: const [],
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

  static AgeEvent ageEvent(
      {int age: 0, List<String> events: const ['Some event']}) {
    return AgeEvent(age: age, events: events);
  }

  static DisplayAgeEvent displayAgeEvent(
      {int id: 0,
      String age: 'Age 0',
      List<String> events: const ['Some event']}) {
    return DisplayAgeEvent(id, age, events);
  }

  static List<DisplayAgeEvent> ageEventsToDisplayAgeEvents(
          List<AgeEvent> ageEvents) =>
      ageEvents
          .map((ageEvent) => DisplayAgeEvent.fromAgeEvent(ageEvent))
          .toList();

  static Job job({
    int id: 1,
    List<Requirement> requirements: const [Requirement.HighSchool],
    List<PersonalityTrait> personalityTraits: const [PersonalityTrait.Charismatic],
  }) {
    return Job(
        id: id,
        name: 'Supervisor',
        salary: 15000,
        requirements: requirements,
        personalityTraits: personalityTraits);
  }

  static DisplayJob displayJob({
    String name: 'Supervisor',
    List<String> requirements: const ['\u2022 High School completed successfully'],
    String salary: '\$15,000/year',
    int id: 1,
    List<String> personalityTraits: const ['\u2022 Charismatic'],
  }) {
    return DisplayJob(id, name, requirements, salary, personalityTraits);
  }

  static JobExperience jobExperience(
      {String name: 'Supervisor', int experience: 2}) {
    return JobExperience(name: name, experience: experience);
  }

  static DisplayJobExperience displayJobExperience(
      {String name: 'Supervisor', String experience: '2 years'}) {
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

  static DisplayCurrentJob displayCurrentJob({
    int id: 1,
    String name: 'Supervisor',
    String salary: '\$15,000/year',
  }) =>
      DisplayCurrentJob(
        id,
        name,
        salary,
      );
}
