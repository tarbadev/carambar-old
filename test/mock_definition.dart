import 'package:carambar/repository/character_repository.dart';
import 'package:carambar/service/character_service.dart';
import 'package:carambar/service/client/character_client.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockCharacterService extends Mock implements CharacterService {}
class MockCharacterClient extends Mock implements CharacterClient {}
class MockInternalFileRepository extends Mock implements CharacterRepository {}
class MockClient extends Mock implements http.Client {}

class Mocks {
  static final CharacterService characterService = MockCharacterService();
  static final CharacterClient characterClient = MockCharacterClient();
  static final CharacterRepository internalFileRepository = MockInternalFileRepository();
  static final http.Client client = MockClient();
}