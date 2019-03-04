import 'package:carambar/repository/character_repository.dart';
import 'package:carambar/service/character_service.dart';
import 'package:carambar/service/client/character_client.dart';
import 'package:kiwi/kiwi.dart';
import 'package:http/http.dart' as http;

part 'application_injector.g.dart';

abstract class ApplicationInjector {
  void configure() {
    configureAnnotations();
    configureInstances();
  }

  @Register.factory(CharacterRepository, resolvers: {String: "characterFileName"})
  @Register.factory(
    CharacterService,
    name: "characterService",
    resolvers: {CharacterClient: 'characterClient'},
  )
  void configureAnnotations();

  void configureInstances() {
    final Container container = Container();
    container.registerInstance(
        CharacterClient(http.Client()),
        name: "characterClient"
    );
    container.registerInstance("character.json", name: "characterFileName");
  }
}

ApplicationInjector getApplicationInjector() => new _$ApplicationInjector();
