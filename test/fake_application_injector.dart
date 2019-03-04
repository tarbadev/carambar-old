import 'package:kiwi/kiwi.dart';

import 'mock_definition.dart';

void setupTest() {
  final Container container = Container();
  container.registerInstance(Mocks.characterService, name: "characterService");
}