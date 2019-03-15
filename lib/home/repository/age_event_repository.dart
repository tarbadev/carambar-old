import 'dart:convert';

import 'package:carambar/home/domain/entity/age_event.dart';
import 'package:carambar/home/repository/entity/age_event_entity.dart';
import 'package:carambar/application/repository/internal_file_repository.dart';

class AgeEventRepository extends InternalFileRepository {
  AgeEventRepository(String fileName) : super(fileName);

  Future<List<AgeEvent>> readAgeEvents() async {
    String ageEventsFileContent = await read();
    if (ageEventsFileContent == null) {
      return null;
    }

    final List<dynamic> jsonData = json.decode(ageEventsFileContent);

    return List.from(jsonData.map((ageEventMap) => AgeEventEntity.fromJson(ageEventMap).toAgeEvent()));
  }

  Future<void> save(List<AgeEvent> ageEvents) async {
    await write(ageEvents.map((ageEvent) => AgeEventEntity.fromAgeEvent(ageEvent)).toList());
  }
}
