import 'package:carambar/application/domain/entity/initiate_event.dart';
import 'package:carambar/application/repository/entity/game_event_entity.dart';
import 'package:carambar/application/repository/internal_file_repository.dart';

class GameRepository extends InternalFileRepository {
  GameRepository(String fileName) : super(fileName);

  Future createGame(InitiateEvent event) async {
    await writeList([GameEventEntity.fromInitiateEvent(event)]);
  }
}