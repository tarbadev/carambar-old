import 'package:carambar/core_application_injector.dart';
import 'package:carambar/service/client/character_client.dart';
import 'package:http/http.dart' as http;
import 'package:kiwi/kiwi.dart';

class ApplicationInjector {
  void configure() {
    getCoreApplicationInjector().configure();
    configureInstances();
  }

  void configureInstances() {
    final Container container = Container();
    container.registerInstance(
        CharacterClient(http.Client()),
        name: 'characterClient'
    );
    container.registerInstance('character.json', name: 'characterFileName');
    container.registerInstance('ageEvents.json', name: 'ageEventsFileName');
  }
}
ApplicationInjector getApplicationInjector() => ApplicationInjector();
