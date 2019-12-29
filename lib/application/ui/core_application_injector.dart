import 'package:carambar/application/domain/service/game_service.dart';
import 'package:carambar/application/repository/game_repository.dart';
import 'package:carambar/character/domain/service/character_service.dart';
import 'package:carambar/character/domain/service/client/character_client.dart';
import 'package:carambar/work/domain/service/work_service.dart';
import 'package:kiwi/kiwi.dart';

part 'core_application_injector.g.dart';

abstract class CoreApplicationInjector {
  void configure() {
    configureAnnotations();
  }

  @Register.factory(GameRepository, resolvers: {String: 'gameFileName'})
  @Register.factory(GameService)
  @Register.factory(CharacterService)
  @Register.factory(WorkService)
  void configureAnnotations();
}

CoreApplicationInjector getCoreApplicationInjector() => new _$CoreApplicationInjector();
