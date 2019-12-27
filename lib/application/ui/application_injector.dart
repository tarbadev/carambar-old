import 'package:carambar/application/ui/application_middleware.dart';
import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/application/ui/core_application_injector.dart';
import 'package:carambar/application/ui/application_reducer.dart';
import 'package:carambar/character/domain/service/client/character_client.dart';
import 'package:http/http.dart' as http;
import 'package:kiwi/kiwi.dart';
import 'package:redux/redux.dart';

class ApplicationInjector {
  void configure() {
    getCoreApplicationInjector().configure();
    configureInstances();
  }

  void configureInstances() {
    final _store = Store<ApplicationState>(
      applicationReducer,
      initialState: ApplicationState.initial(),
      middleware: createApplicationMiddleware(),
    );

    final Container container = Container();
    container.registerInstance(CharacterClient(http.Client()));
    container.registerInstance(_store);
    container.registerInstance('character.json', name: 'characterFileName');
    container.registerInstance('ageEvents.json', name: 'ageEventsFileName');
    container.registerInstance('game.json', name: 'gameFileName');
  }
}
ApplicationInjector getApplicationInjector() => ApplicationInjector();
