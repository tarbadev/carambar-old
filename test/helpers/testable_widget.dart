import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/character/ui/entity/display_character.dart';
import 'package:carambar/home/ui/entity/display_age_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'mock_definition.dart';

Widget buildTestableWidget(
  Widget widget, {
  List<DisplayAgeEvent> displayAgeEvents,
  bool isEndLifeDialogVisible: false,
  DisplayCharacter displayCharacter,
  double availableCash: 4523.67,
  List<String> availableJobs: Mocks.defaultAvailableJobs,
  String jobRequirements: 'High School completed successfully',
  bool isJobRequirementsDialogVisible: false,
}) {
  Mocks.setupMockStore(
      displayAgeEvents: displayAgeEvents,
      isEndLifeDialogVisible: isEndLifeDialogVisible,
      displayCharacter: displayCharacter,
      availableCash: availableCash,
      availableJobs: availableJobs,
      jobRequirements: jobRequirements,
      isJobRequirementsDialogVisible: isJobRequirementsDialogVisible,
  );

  return MediaQuery(
    data: MediaQueryData(),
    child: StoreProvider<ApplicationState>(
      store: Mocks.store,
      child: MaterialApp(home: Scaffold(body: widget)),
    ),
  );
}
