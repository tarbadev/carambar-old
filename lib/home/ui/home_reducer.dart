import 'package:carambar/home/ui/entity/display_age_event.dart';
import 'package:carambar/home/ui/home_actions.dart';
import 'package:redux/redux.dart';

final Reducer<List<DisplayAgeEvent>> setAgeEventsReducer = combineReducers([
  TypedReducer<List<DisplayAgeEvent>, SetAgeEventsAction>(_setAgeEvents),
]);

List<DisplayAgeEvent> _setAgeEvents(List<DisplayAgeEvent> currentTab, SetAgeEventsAction action) =>
    action.displayAgeEvents;