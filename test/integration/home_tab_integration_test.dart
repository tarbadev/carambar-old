import 'dart:convert';
import 'dart:io';

import 'package:carambar/domain/entity/character.dart';
import 'package:carambar/repository/entity/character_entity.dart';
import 'package:carambar/ui/home_tab.dart';
import 'package:carambar/ui/util/string_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:path_provider/path_provider.dart';

import '../factory.dart';
import '../helpers/testable_widget.dart';
import '../helpers/view/home_tab_view.dart';
import 'integration_application_injector.dart';
import 'package:http/http.dart' as http;

void main() {
  getIntegrationApplicationInjector().configure();
  final http.Client mockHttpClient = getIntegrationApplicationInjector().mockClient;

  setUpAll(() async {
    final directory = await Directory.systemTemp.createTemp();

    const MethodChannel('plugins.flutter.io/path_provider')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getApplicationDocumentsDirectory') {
        return directory.path;
      }
      return null;
    });
  });

  testWidgets('home shows the saved character', (WidgetTester tester) async {
    tester.runAsync(() async {
      var character = Factory.character(age: 45);
      await CharacterStorage.write(character);

      await tester.pumpWidget(buildTestableWidget(HomeTab()));
      var homeTabView = HomeTabView(tester);

      expect(homeTabView.characterInformationView.getCharacterName(),
          "${StringUtils.capitalize(character.firstName)} ${StringUtils.capitalize(character.lastName)}");
      expect(homeTabView.characterInformationView.getCharacterSex(),
          "${StringUtils.capitalize(character.sex)}");
      expect(homeTabView.characterInformationView.getCharacterOrigin(),
          "${StringUtils.capitalize(character.origin)}");
      expect(homeTabView.characterInformationView.getCharacterAge(),
          "${character.age}");
    });
  });

  testWidgets('home shows the generated character', (WidgetTester tester) async {
    tester.runAsync(() async {
      final file = new File('test_resources/characterServiceResponse.json');
      final characterResponse = await file.readAsString();
      var character = Factory.character();

      when(mockHttpClient.get('https://randomuser.me/api/'))
          .thenAnswer((_) async => http.Response(characterResponse, 200));

      await tester.pumpWidget(buildTestableWidget(HomeTab()));
      var homeTabView = HomeTabView(tester);

      expect(homeTabView.characterInformationView.getCharacterName(),
          "${StringUtils.capitalize(character.firstName)} ${StringUtils.capitalize(character.lastName)}");
      expect(homeTabView.characterInformationView.getCharacterSex(),
          "${StringUtils.capitalize(character.sex)}");
      expect(homeTabView.characterInformationView.getCharacterOrigin(),
          "${StringUtils.capitalize(character.origin)}");
      expect(homeTabView.characterInformationView.getCharacterAge(),
          "${character.age}");
    });
  });
}

class CharacterStorage {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File(
        '$path/${getIntegrationApplicationInjector().characterFileName}');
  }

  static Future<String> read() async {
    try {
      final file = await _localFile;

      return await file.readAsString();
    } catch (e) {
      return null;
    }
  }

  static Future<File> write(Character character) async {
    final file = await _localFile;
    return file
        .writeAsString(jsonEncode(CharacterEntity.fromCharacter(character)));
  }
}
