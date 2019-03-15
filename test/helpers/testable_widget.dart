import 'package:carambar/application/ui/application_actions.dart';
import 'package:carambar/home/domain/entity/age_event.dart';
import 'package:carambar/character/domain/entity/character.dart';
import 'package:carambar/application/ui/application_reducer.dart';
import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/application/ui/application_middleware.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';

import 'factory.dart';
import 'mock_definition.dart';

Widget buildTestableWidget(Widget widget, {List<AgeEvent> ageEvents, Character character}) {
  if(ageEvents == null) {
    ageEvents = [Factory.ageEvent()];
  }
  if(character == null) {
    character = Factory.character();
  }

  when(Mocks.characterService.getCharacter()).thenAnswer((_) async => character);
  when(Mocks.ageEventService.getAgeEvents()).thenAnswer((_) async => ageEvents);

  return _FakeApp(child: widget);
}

class _FakeApp extends StatelessWidget {
  final Widget child;

  const _FakeApp({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store =
        Store<ApplicationState>(applicationReducer, initialState: ApplicationState.initial(), middleware: createApplicationMiddleware());

    store.dispatch(InitiateStateAction());

    return MediaQuery(
      data: MediaQueryData(),
      child: StoreProvider<ApplicationState>(
        store: store,
        child: MaterialApp(home: child),
      ),
    );
  }
}
