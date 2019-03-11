import 'package:carambar/repository/age_event_repository.dart';
import 'package:carambar/repository/character_repository.dart';
import 'package:carambar/service/age_event_service.dart';
import 'package:carambar/service/character_service.dart';
import 'package:carambar/service/client/character_client.dart';
import 'package:carambar/ui/presenter/age_event_presenter.dart';
import 'package:carambar/ui/presenter/character_presenter.dart';
import 'package:kiwi/kiwi.dart';

part 'core_application_injector.g.dart';

abstract class CoreApplicationInjector {
  void configure() {
    configureAnnotations();
  }

  @Register.factory(AgeEventRepository, resolvers: {String: 'ageEventsFileName'})
  @Register.factory(AgeEventService)
  @Register.factory(AgeEventPresenter, name: 'ageEventPresenter')
  @Register.factory(CharacterRepository, resolvers: {String: 'characterFileName'})
  @Register.factory(
    CharacterService,
    resolvers: {CharacterClient: 'characterClient'},
  )
  @Register.factory(CharacterPresenter, name: 'characterPresenter')
  void configureAnnotations();
}

CoreApplicationInjector getCoreApplicationInjector() => new _$CoreApplicationInjector();
