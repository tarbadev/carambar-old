import 'package:carambar/domain/entity/character.dart';
import 'package:carambar/service/client/character_client_response.dart';
import 'package:flutter/material.dart';
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