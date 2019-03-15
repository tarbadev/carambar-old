import 'package:kiwi/kiwi.dart';

import 'mock_definition.dart';

void setupDependencyInjectorForTest() {
  final Container container = Container();
  container.registerInstance(Mocks.ageEventService);
  container.registerInstance(Mocks.characterService);
}