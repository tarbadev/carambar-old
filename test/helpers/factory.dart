import 'package:carambar/character/domain/entity/character.dart';
import 'package:carambar/character/domain/entity/nationality.dart';
import 'package:carambar/character/domain/service/client/character_client_response.dart';
import 'package:carambar/character/ui/entity/display_character.dart';
import 'package:carambar/home/domain/entity/age_event.dart';
import 'package:carambar/home/ui/entity/display_age_event.dart';
import 'package:carambar/work/domain/entity/job.dart';
import 'package:carambar/work/ui/entity/display_job.dart';

abstract class Factory {
  static const List<Graduate> _factoryGraduates = [];

  static Character character({int age: 18, List<Graduate> graduates: _factoryGraduates, Job job}) {
    return Character(
      firstName: 'john',
      lastName: 'doe',
      gender: 'male',
      age: age,
      origin: Nationality.unitedStates,
      graduates: graduates,
      job: job,
    );
  }

  static DisplayCharacter displayCharacter({age: '18', ageCategory: 'Adult', school: 'None', DisplayJob job}) {
    return DisplayCharacter(
      'John Doe',
      'Male',
      age,
      'United States',
      ageCategory,
      school,
      [],
      job,
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
  static Job job({int id: 1, List<Requirement> requirements: _factoryRequirements}) {
    return Job(id: id, name: 'Supervisor', salary: 15000, requirements: requirements);
  }

  static const List<String> _factoryDisplayRequirements = ['\u2022 High School completed successfully'];
  static DisplayJob displayJob(
      {String name: 'Supervisor',
      List<String> requirements: _factoryDisplayRequirements,
      String salary: '\$15,000/year',
      int id: 1}) {
    return DisplayJob(id, name, requirements, salary);
  }
}
