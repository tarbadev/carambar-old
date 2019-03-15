import 'package:carambar/home/domain/entity/age_event.dart';
import 'package:carambar/character/domain/entity/character.dart';
import 'package:carambar/character/domain/entity/nationality.dart';
import 'package:carambar/character/domain/service/client/character_client_response.dart';
import 'package:carambar/home/ui/entity/display_age_event.dart';
import 'package:carambar/character/ui/entity/display_character.dart';

class Factory {
  static Character character({int age: 18}) {
    return Character(
      firstName: "john",
      lastName: "doe",
      gender: "male",
      age: age,
      origin: Nationality.unitedStates,
    );
  }

  static DisplayCharacter displayCharacter({age: '18', ageCategory: 'Adult'}) {
    return DisplayCharacter(
      "John Doe",
      "Male",
      age,
      "United States",
      ageCategory,
      'None',
    );
  }

  static CharacterClientModel characterClientModel() {
    return CharacterClientModel(
      gender: "male",
      name: Name(
        title: "mr",
        first: "john",
        last: "doe",
      ),
      email: "imogen.johnson@example.com",
      nat: "US",
      picture: Picture(
        large: "https://randomuser.me/api/portraits/women/29.jpg",
        medium: "https://randomuser.me/api/portraits/med/women/29.jpg",
        thumbnail: "https://randomuser.me/api/portraits/thumb/women/29.jpg",
      ),
    );
  }

  static const List<String> _factoryEventList = ['Some event'];

  static AgeEvent ageEvent(
      {int age: 0, List<String> events: _factoryEventList}) {
    return AgeEvent(age: age, events: events);
  }

  static DisplayAgeEvent displayAgeEvent(
      {int id: 0,
      String age: "Age 0",
      List<String> events: _factoryEventList}) {
    return DisplayAgeEvent(id, age, events);
  }
}
