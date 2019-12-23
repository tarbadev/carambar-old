import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/character/ui/character_middleware.dart';
import 'package:carambar/home/ui/home_middleware.dart';
import 'package:carambar/settings/ui/settings_middleware.dart';
import 'package:carambar/work/ui/work_middleware.dart';
import 'package:redux/redux.dart';

import 'application_actions.dart';

List<Middleware<ApplicationState>> createApplicationMiddleware() {
  List<Middleware<ApplicationState>> applicationMiddleware = [
    TypedMiddleware<ApplicationState, InitiateStateAction>(
        initiateAvailableCash),
  ];

  applicationMiddleware.addAll(createHomeMiddleware());
  applicationMiddleware.addAll(createCharacterMiddleware());
  applicationMiddleware.addAll(createSettingsMiddleware());
  applicationMiddleware.addAll(createWorkMiddleware());

  return applicationMiddleware;
}

Future initiateAvailableCash(Store<ApplicationState> store,
    InitiateStateAction action, NextDispatcher next) async {

  store.dispatch(SetAvailableCashAction(0));

  next(action);
}
