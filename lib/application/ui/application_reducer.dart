import 'package:carambar/application/ui/application_actions.dart';
import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/character/ui/character_reducer.dart';
import 'package:carambar/home/ui/home_reducer.dart';
import 'package:redux/redux.dart';

ApplicationState applicationReducer(ApplicationState state, action) => ApplicationState(
      setCurrentTabReducer(state.currentTab, action),
      setCharacterReducer(state.character, action),
      setAgeEventsReducer(state.ageEvents, action),
    );

final Reducer<int> setCurrentTabReducer = combineReducers([
  TypedReducer<int, SelectTabAction>(_selectTab),
]);

int _selectTab(int currentTab, SelectTabAction action) => action.index;
