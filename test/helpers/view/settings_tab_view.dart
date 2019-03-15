import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base_view.dart';

class SettingsTabView extends BaseView {
  SettingsTabView(WidgetTester tester) : super(tester);

  EndLifeDialogElement get endLifeDialog => EndLifeDialogElement(tester);

  Finder get _endLifeButtonFinder => find.byKey(Key("endLifeButton"));

  Future<void> clickOnEndLifeButton() async {
    await tester.tap(_endLifeButtonFinder);
    await tester.pump();
  }
}

class EndLifeDialogElement {
  final WidgetTester _tester;

  EndLifeDialogElement(this._tester);

  Finder get _dialogFinder => find.byType(AlertDialog);

  Finder get _confirmButtonFinder => find.byKey(Key('endLifeConfirmButton'));

  bool get isVisible {
    try {
      _tester.renderObject<RenderBox>(_dialogFinder);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> confirmEndLife() async {
    await _tester.tap(_confirmButtonFinder);
    await _tester.pump();
  }
}
