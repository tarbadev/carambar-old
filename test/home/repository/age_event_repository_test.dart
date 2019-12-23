import 'package:carambar/home/domain/entity/age_event.dart';
import 'package:carambar/home/repository/age_event_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/factory.dart';
import '../../helpers/storage/storage.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Storage.setupStorage();
  });

  group('AgeEventRepository', () {
    AgeEventRepository ageEventRepository;
    AgeEventStorage ageEventStorage;

    setUp(() async {
      ageEventStorage = AgeEventStorage();
      await ageEventStorage.delete();

      ageEventRepository = AgeEventRepository(ageEventStorage.fileName);
    });

    test('readAgeEvents returns the saved ageEvent list', () async {
      final List<AgeEvent> ageEvents = [
        Factory.ageEvent(age: 0),
        Factory.ageEvent(age: 1)
      ];
      await ageEventStorage.store(ageEvents);

      List<AgeEvent> returnedAgeEvents =
          await ageEventRepository.readAgeEvents();

      expect(returnedAgeEvents, ageEvents);
    });

    test('readAgeEvents returns null when there is no existing file', () async {
      List<AgeEvent> returnedAgeEvents =
          await ageEventRepository.readAgeEvents();

      expect(returnedAgeEvents, isNull);
    });

    test('save saves the ageEvent list to file', () async {
      final List<AgeEvent> ageEvents = [
        Factory.ageEvent(age: 0),
        Factory.ageEvent(age: 1, events: [])
      ];

      await ageEventRepository.save(ageEvents);

      final expectedJsonString = '[' +
          '{' +
          '"age":0,' +
          '"events":["Some event"]' +
          '},' +
          '{' +
          '"age":1,' +
          '"events":[]' +
          '}' +
          ']';

      expect(await ageEventStorage.read(), expectedJsonString);
    });
  });
}
