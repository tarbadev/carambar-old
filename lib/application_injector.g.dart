// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_injector.dart';

// **************************************************************************
// InjectorGenerator
// **************************************************************************

class _$ApplicationInjector extends ApplicationInjector {
  void configureAnnotations() {
    final Container container = Container();
    container.registerFactory((c) => InternalFileRepository());
    container.registerFactory(
        (c) => CharacterService(
            c<InternalFileRepository>(), c<CharacterClient>('characterClient')),
        name: 'characterService');
  }
}
