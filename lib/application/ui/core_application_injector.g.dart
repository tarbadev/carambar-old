// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_application_injector.dart';

// **************************************************************************
// InjectorGenerator
// **************************************************************************

class _$CoreApplicationInjector extends CoreApplicationInjector {
  void configureAnnotations() {
    final Container container = Container();
    container.registerFactory((c) => GameRepository(c<String>('gameFileName')));
    container.registerFactory((c) => GameService(c<GameRepository>()));
    container.registerFactory((c) => CharacterService(c<CharacterClient>()));
    container.registerFactory((c) => WorkService());
  }
}
