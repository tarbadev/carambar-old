import 'package:carambar/global_reducer.dart';
import 'package:carambar/middleware.dart';
import 'package:carambar/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

Widget buildTestableWidget(Widget widget) {
  final store = Store<GlobalState>(globalReducer,
      initialState: GlobalState.initial(),
      middleware: createStoreMiddleware());

  return MediaQuery(
    data: MediaQueryData(),
    child: StoreProvider<GlobalState>(
      store: store,
      child: MaterialApp(home: widget),
    ),
  );
}