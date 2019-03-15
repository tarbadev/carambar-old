import 'package:carambar/actions.dart';
import 'package:carambar/store.dart';
import 'package:redux/redux.dart';

GlobalState globalReducer(GlobalState state, action) => GlobalState(selectTabReducer(state.currentTab, action));

final Reducer<int> selectTabReducer = combineReducers([
  TypedReducer<int, SelectTabAction>(_selectTab),
]);

int _selectTab(int currentTab, SelectTabAction action) => action.index;