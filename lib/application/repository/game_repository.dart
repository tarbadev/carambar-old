import 'dart:convert';

import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:carambar/application/repository/entity/game_event_entity.dart';
import 'package:carambar/application/repository/internal_file_repository.dart';

class GameRepository extends InternalFileRepository {
  GameRepository(String fileName) : super(fileName);

  Future save(List<GameEvent> events) async {
    var eventList = events
            .map((event) => GameEventEntity.fromEvent(event))
            .toList();

    await write(eventList);
  }

  Future<List<GameEvent>> readEvents() async {
    final stringData = await read();

    if (stringData == null) {
      return null;
    }

    List<dynamic> eventList = json.decode(stringData);
    return eventList
        .map((event) => GameEventEntity.fromJson(event).toEvent())
        .toList();
  }
}