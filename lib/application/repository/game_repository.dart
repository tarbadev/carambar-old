import 'package:carambar/application/domain/entity/initiate_event.dart';
import 'package:carambar/application/repository/entity/initiate_event_entity.dart';
import 'package:carambar/application/repository/internal_file_repository.dart';

class GameRepository extends InternalFileRepository {
  GameRepository(String fileName) : super(fileName);

  Future save(List<InitiateEvent> events) async {
    var eventsToStore = events.map((event) => InitiateEventEntity.fromInitiateEvent(event));
    await writeList(eventsToStore.toList());
  }
}