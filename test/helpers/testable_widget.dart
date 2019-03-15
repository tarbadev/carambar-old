import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/character/domain/entity/character.dart';
import 'package:carambar/home/ui/entity/display_age_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'mock_definition.dart';

Widget buildTestableWidget(Widget widget, {List<DisplayAgeEvent> displayAgeEvents, Character character}) {
  Mocks.setupMockStore(displayAgeEvents: displayAgeEvents);

  return MediaQuery(
    data: MediaQueryData(),
    child: StoreProvider<ApplicationState>(
      store: Mocks.mockStore,
      child: MaterialApp(home: widget),
    ),
  );
}
