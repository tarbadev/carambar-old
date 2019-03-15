import 'package:carambar/settings/ui/settings_actions.dart';
import 'package:redux/redux.dart';

final Reducer<bool> setEndLifeDialogVisibleReducer = combineReducers([
  TypedReducer<bool, SetEndLifeDialogVisibleAction>(_setIsEndLifeDialogVisible),
]);

bool _setIsEndLifeDialogVisible(bool isCurrentlyVisible, SetEndLifeDialogVisibleAction action) => action.visible;