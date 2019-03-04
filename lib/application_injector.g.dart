// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_injector.dart';

// **************************************************************************
// InjectorGenerator
// **************************************************************************

class _$ApplicationInjector extends ApplicationInjector {
  void configureAnnotations() {
    final Container container = Container();
    container.registerFactory(
        (c) => CharacterRepository(c<String>('characterFileName')));
    container.registerFactory(
        (c) => CharacterService(
            c<CharacterRepository>(), c<CharacterClient>('characterClient')),
        name: 'characterService');
  }
}
