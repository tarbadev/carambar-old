import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/character/ui/character_middleware.dart';
import 'package:carambar/home/ui/home_middleware.dart';
import 'package:carambar/settings/ui/settings_middleware.dart';
import 'package:redux/redux.dart';

List<Middleware<ApplicationState>> createApplicationMiddleware() {
  List<Middleware<ApplicationState>> applicationMiddleware = [];

  applicationMiddleware.addAll(createHomeMiddleware());
  applicationMiddleware.addAll(createCharacterMiddleware());
  applicationMiddleware.addAll(createSettingsMiddleware());

  return applicationMiddleware;
}
