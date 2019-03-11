import 'package:carambar/domain/entity/age_event.dart';
import 'package:carambar/domain/entity/character.dart';
import 'package:carambar/domain/entity/nationality.dart';
import 'package:carambar/service/client/character_client_response.dart';
import 'package:carambar/ui/presenter/display_age_event.dart';
import 'package:carambar/ui/presenter/display_character.dart';

import 'helpers/view/age_event_view.dart';

class Factory {
  static Character character({int age: 18}) {
    return Character(
      firstName: "john",
      lastName: "doe",
      sex: "male",
      age: age,
      origin: Nationality.unitedStates,
    );
  }

  static DisplayCharacter displayCharacter() {
    return DisplayCharacter(
      "John Doe",
      "Male",
      "18",
      "United States",
      "Adult",
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

  static AgeEvent ageEvent({int age: 0, List<String> events: _factoryEventList}) {
    return AgeEvent(age: age, events: events);
  }

  static DisplayAgeEvent displayAgeEvent({int id: 0, String age: "Age 0", List<String> events: _factoryEventList}) {
    return DisplayAgeEvent(id, age, events);
  }

  static eventView({int age: 0}) {
    return AgeEventView(age, ['Some event']);
  }
}
