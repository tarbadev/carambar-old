import 'package:carambar/actions.dart';
import 'package:carambar/domain/entity/age_event.dart';
import 'package:carambar/domain/entity/character.dart';
import 'package:carambar/global_reducer.dart';
import 'package:carambar/global_state.dart';
import 'package:carambar/middleware.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';

import '../factory.dart';
import '../mock_definition.dart';

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
        Store<GlobalState>(globalReducer, initialState: GlobalState.initial(), middleware: createStoreMiddleware());

    store.dispatch(InitiateStateAction());

    return MediaQuery(
      data: MediaQueryData(),
      child: StoreProvider<GlobalState>(
        store: store,
        child: MaterialApp(home: child),
      ),
    );
  }
}
