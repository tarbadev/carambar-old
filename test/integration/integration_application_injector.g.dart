// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'integration_application_injector.dart';

// **************************************************************************
// InjectorGenerator
// **************************************************************************

class _$IntegrationApplicationInjector extends IntegrationApplicationInjector {
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
