import 'package:kiwi/kiwi.dart';

import 'mock_definition.dart';

void setupDependencyInjectorForTest() {
  final Container container = Container();
  container.registerInstance(Mocks.gameService);
  container.registerInstance(Mocks.characterService);
  container.registerInstance(Mocks.workService);
  container.registerInstance(Mocks.store);
}