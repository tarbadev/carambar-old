import 'package:carambar/actions.dart';
import 'package:carambar/global_state.dart';
import 'package:carambar/ui/entity/display_age_event.dart';
import 'package:carambar/ui/entity/display_character.dart';
import 'package:redux/redux.dart';

GlobalState globalReducer(GlobalState state, action) => GlobalState(
      selectTabReducer(state.currentTab, action),
      setCharacterReducer(state.character, action),
      setAgeEventsReducer(state.ageEvents, action),
    );

final Reducer<int> selectTabReducer = combineReducers([
  TypedReducer<int, SelectTabAction>(_selectTab),
]);

int _selectTab(int currentTab, SelectTabAction action) => action.index;

final Reducer<DisplayCharacter> setCharacterReducer = combineReducers([
  TypedReducer<DisplayCharacter, SetCharacterAction>(_setCharacter),
]);

DisplayCharacter _setCharacter(DisplayCharacter currentTab, SetCharacterAction action) => action.displayCharacter;

final Reducer<List<DisplayAgeEvent>> setAgeEventsReducer = combineReducers([
  TypedReducer<List<DisplayAgeEvent>, SetAgeEventsAction>(_setAgeEvents),
]);

List<DisplayAgeEvent> _setAgeEvents(List<DisplayAgeEvent> currentTab, SetAgeEventsAction action) =>
    action.displayAgeEvents;
