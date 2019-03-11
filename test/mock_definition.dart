import 'package:carambar/repository/character_repository.dart';
import 'package:carambar/repository/age_event_repository.dart';
import 'package:carambar/service/character_service.dart';
import 'package:carambar/service/client/character_client.dart';
import 'package:carambar/service/age_event_service.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockCharacterService extends Mock implements CharacterService {}
class MockCharacterClient extends Mock implements CharacterClient {}
class MockCharacterRepository extends Mock implements CharacterRepository {}

class MockAgeEventService extends Mock implements AgeEventService {}
class MockAgeEventRepository extends Mock implements AgeEventRepository {}

class MockClient extends Mock implements http.Client {}

class Mocks {
  static final CharacterService characterService = MockCharacterService();
  static final CharacterClient characterClient = MockCharacterClient();
  static final CharacterRepository characterRepository = MockCharacterRepository();

  static final AgeEventService ageEventService = MockAgeEventService();
  static final AgeEventRepository ageEventRepository = MockAgeEventRepository();

  static final http.Client client = MockClient();
}
