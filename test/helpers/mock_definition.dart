import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/character/domain/service/character_service.dart';
import 'package:carambar/character/domain/service/client/character_client.dart';
import 'package:carambar/character/repository/character_repository.dart';
import 'package:carambar/character/ui/entity/display_character.dart';
import 'package:carambar/home/domain/service/age_event_service.dart';
import 'package:carambar/home/repository/age_event_repository.dart';
import 'package:carambar/home/ui/entity/display_age_event.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';

import 'factory.dart';

class MockCharacterService extends Mock implements CharacterService {}
class MockCharacterClient extends Mock implements CharacterClient {}
class MockCharacterRepository extends Mock implements CharacterRepository {}

class MockAgeEventService extends Mock implements AgeEventService {}
class MockAgeEventRepository extends Mock implements AgeEventRepository {}

class MockClient extends Mock implements http.Client {}

class MockStore extends Mock implements Store<ApplicationState> {}
class MockApplicationState extends Mock implements ApplicationState {}
abstract class MockFunction {
  next(dynamic action);
}
class MockNext extends Mock implements MockFunction {}

class Mocks {
  static final CharacterService characterService = MockCharacterService();
  static final CharacterClient characterClient = MockCharacterClient();
  static final CharacterRepository characterRepository = MockCharacterRepository();

  static final AgeEventService ageEventService = MockAgeEventService();
  static final AgeEventRepository ageEventRepository = MockAgeEventRepository();

  static final http.Client client = MockClient();

  static final Store<ApplicationState> store = MockStore();
  static final MockNext mockNext = MockNext();
  static final NextDispatcher next = (dynamic action) => mockNext.next(action);
  static final ApplicationState applicationState = MockApplicationState();

  static setupMockStore({List<DisplayAgeEvent> displayAgeEvents, bool isEndLifeDialogVisible, DisplayCharacter displayCharacter, double availableCash}) {
    if (displayAgeEvents == null) {
      displayAgeEvents = [Factory.displayAgeEvent()];
    }
    if (isEndLifeDialogVisible == null) {
      isEndLifeDialogVisible = false;
    }
    if (displayCharacter == null) {
      displayCharacter = Factory.displayCharacter();
    }
    if (availableCash == null) {
      availableCash = 4523.67;
    }

    reset(store);
    reset(applicationState);
    reset(mockNext);

    when(store.state).thenReturn(applicationState);
    when(store.onChange).thenAnswer((_) => Stream.empty());
    when(applicationState.currentTab).thenReturn(0);
    when(applicationState.character).thenReturn(displayCharacter);
    when(applicationState.ageEvents).thenReturn(displayAgeEvents);
    when(applicationState.isEndLifeDialogVisible).thenReturn(isEndLifeDialogVisible);
    when(applicationState.availableCash).thenReturn(availableCash);
  }
}
