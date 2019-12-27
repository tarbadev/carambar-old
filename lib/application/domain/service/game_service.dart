import 'package:carambar/application/domain/entity/initiate_event.dart';
import 'package:carambar/application/repository/game_repository.dart';

class GameService {
  final GameRepository gameRepository;

  GameService(this.gameRepository);

  Future addEvent(InitiateEvent event) async {
    await gameRepository.save([event]);
  }
}