import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/character/domain/service/client/character_client_response.dart';
import 'package:http/http.dart' as http;

class CharacterClient {
  http.Client _client;

  CharacterClient(this._client);

  Future<Character> generateCharacter() async {
    final response = await _client.get('https://randomuser.me/api/');
    final characterClientResponse = characterClientResponseFromJson(response.body);
    return characterClientResponse.toCharacterList().first;
  }
}