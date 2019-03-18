import 'package:flutter_test/flutter_test.dart';

import 'base_view_tester.dart';

class SettingsTabView extends BaseViewTester {
  SettingsTabView(WidgetTester tester) : super(tester);

  EndLifeDialogElement get endLifeDialog => EndLifeDialogElement(tester);

  Future<void> tapOnEndLifeButton() async {
    await tapOnButtonByKey('endLifeButton');
  }
}

class EndLifeDialogElement extends BaseViewTester {
  EndLifeDialogElement(tester): super(tester);

  bool get isVisible => widgetExists('EndLifeDialog');

  Future<void> confirmEndLife() async => await tapOnButtonByKey('EndLifeDialog__ConfirmButton');
  Future<void> cancelEndLife() async => await tapOnButtonByKey('EndLifeDialog__CancelButton');
}
