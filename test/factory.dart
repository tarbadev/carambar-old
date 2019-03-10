import 'package:carambar/domain/entity/character.dart';
import 'package:carambar/domain/entity/nationality.dart';
import 'package:carambar/service/client/character_client_response.dart';

class Factory {
  static Character character({int age: 18}) {
    return Character(
        firstName: "john",
        lastName: "doe",
        sex: "male",
        age: age,
        origin: Nationality.unitedStates
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
}