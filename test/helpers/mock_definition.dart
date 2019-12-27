import 'package:carambar/application/domain/service/game_service.dart';
import 'package:carambar/application/repository/game_repository.dart';
import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/character/domain/service/character_service.dart';
import 'package:carambar/character/domain/service/client/character_client.dart';
import 'package:carambar/character/repository/character_repository.dart';
import 'package:carambar/home/domain/service/age_event_service.dart';
import 'package:carambar/home/repository/age_event_repository.dart';
import 'package:carambar/home/ui/entity/display_age_event.dart';
import 'package:carambar/work/domain/service/work_service.dart';
import 'package:carambar/work/ui/entity/display_job.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';

import 'factory.dart';

class MockGameService extends Mock implements GameService {}
class MockGameRepository extends Mock implements GameRepository {}

class MockCharacterService extends Mock implements CharacterService {}
class MockCharacterClient extends Mock implements CharacterClient {}
class MockCharacterRepository extends Mock implements CharacterRepository {}

class MockAgeEventService extends Mock implements AgeEventService {}
class MockAgeEventRepository extends Mock implements AgeEventRepository {}

class MockWorkService extends Mock implements WorkService {}

class MockClient extends Mock implements http.Client {}

class MockStore extends Mock implements Store<ApplicationState> {}
class MockApplicationState extends Mock implements ApplicationState {}
abstract class MockFunction {
  next(dynamic action);
}
class MockNext extends Mock implements MockFunction {}

class Mocks {
  static final GameService gameService = MockGameService();
  static final GameRepository gameRepository = MockGameRepository();

  static final CharacterService characterService = MockCharacterService();
  static final CharacterClient characterClient = MockCharacterClient();
  static final CharacterRepository characterRepository = MockCharacterRepository();

  static final AgeEventService ageEventService = MockAgeEventService();
  static final AgeEventRepository ageEventRepository = MockAgeEventRepository();

  static final WorkService workService = MockWorkService();

  static final http.Client client = MockClient();

  static final Store<ApplicationState> store = MockStore();
  static final MockNext mockNext = MockNext();
  static final NextDispatcher next = (dynamic action) => mockNext.next(action);
  static final ApplicationState applicationState = MockApplicationState();

  static setupMockStore({
    List<DisplayAgeEvent> displayAgeEvents = const [],
    bool isEndLifeDialogVisible: false,
    Character character,
    double availableCash: 4523.67,
    List<DisplayJob> availableJobs: const [],
  }) {
    if (character == null) {
      character = Factory.character();
    }

    reset(store);
    reset(applicationState);
    reset(mockNext);

    when(store.state).thenReturn(applicationState);
    when(store.onChange).thenAnswer((_) => Stream.empty());
    when(applicationState.currentTab).thenReturn(0);
    when(applicationState.character).thenReturn(character);
    when(applicationState.ageEvents).thenReturn(displayAgeEvents);
    when(applicationState.isEndLifeDialogVisible).thenReturn(isEndLifeDialogVisible);
    when(applicationState.availableCash).thenReturn(availableCash);
    when(applicationState.availableJobs).thenReturn(availableJobs);
  }
}
