import 'dart:io';

import 'package:carambar/character/domain/service/client/character_client.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

import '../../../../helpers/factory.dart';
import '../../../../helpers/mock_definition.dart';


void main() {
  group('CharacterClient', () {
    CharacterClient characterClient;

    setUp(() {
      characterClient = CharacterClient(Mocks.client);
    });

    test('getCharacter generates a new character and saves it', () async {
      final file = new File('test_resources/characterServiceResponse.json');
      final characterResponse = await file.readAsString();
      final expectedCharacter = Factory.character(age: null, graduates: []);

      when(Mocks.client.get('https://randomuser.me/api/'))
          .thenAnswer((_) async => http.Response(characterResponse, 200));

      expect(await characterClient.generateCharacter(), expectedCharacter);
    });
  });
}
