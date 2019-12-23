import 'dart:io';

import 'package:carambar/character/domain/service/client/character_client.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/factory.dart';
import '../../../../helpers/mock_definition.dart';


void main() {
  group('CharacterClient', () {
    CharacterClient characterClient;

    setUp(() {
      characterClient = CharacterClient(Mocks.client);
    });

    test('getCharacter generates a new character and saves it', () async {
      var filePath = 'test_resources/characterServiceResponse.json';
      var characterResponse;

      try {
        characterResponse = await File(filePath).readAsString();
      } catch (e) {
        characterResponse = await File("../" + filePath).readAsString();
      }

      final expectedCharacter = Factory.character(age: 0, graduates: []);

      when(Mocks.client.get('https://randomuser.me/api/'))
          .thenAnswer((_) async => http.Response(characterResponse, 200));

      expect(await characterClient.generateCharacter(), expectedCharacter);
    });
  });
}
