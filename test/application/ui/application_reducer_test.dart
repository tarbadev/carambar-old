import 'package:carambar/application/ui/application_actions.dart';
import 'package:carambar/application/ui/application_reducer.dart';
import 'package:test_api/test_api.dart';

void main() {
  group('Application Reducer', () {
    test('calls the characterService and saves the new character in state and calls next action', () async {
      expect(addAvailableCash(2000, AddAvailableCashAction(15000)), 17000);
    });
  });
}
