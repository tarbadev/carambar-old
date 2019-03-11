// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_application_injector.dart';

// **************************************************************************
// InjectorGenerator
// **************************************************************************

class _$CoreApplicationInjector extends CoreApplicationInjector {
  void configureAnnotations() {
    final Container container = Container();
    container.registerFactory(
        (c) => AgeEventRepository(c<String>('ageEventsFileName')));
    container.registerFactory((c) => AgeEventService(c<AgeEventRepository>()),
        name: 'ageEventService');
    container.registerFactory(
        (c) => CharacterRepository(c<String>('characterFileName')));
    container.registerFactory(
        (c) => CharacterService(
            c<CharacterRepository>(),
            c<CharacterClient>('characterClient'),
            c<AgeEventService>('ageEventService')),
        name: 'characterService');
  }
}
