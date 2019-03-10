import 'package:carambar/repository/character_repository.dart';
import 'package:carambar/service/character_service.dart';
import 'package:carambar/service/client/character_client.dart';
import 'package:kiwi/kiwi.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

part 'integration_application_injector.g.dart';

class MockClient extends Mock implements http.Client {}

abstract class IntegrationApplicationInjector {
  final String characterFileName = 'testingCharacter.json';
  final http.Client mockClient = MockClient();

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
        CharacterClient(mockClient),
        name: "characterClient"
    );
    container.registerInstance(characterFileName, name: "characterFileName");
  }
}

IntegrationApplicationInjector getIntegrationApplicationInjector() => new _$IntegrationApplicationInjector();