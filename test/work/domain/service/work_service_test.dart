import 'package:carambar/work/domain/service/work_service.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/factory.dart';

void main() {
  group('WorkService', () {
    WorkService workService;

    setUp(() {
      workService = WorkService();
    });

    test('getJob returns the job', () async {
      final expectedWork = Factory.job(id: 1, personalityTraits: []);

      expect(workService.getJob(1), expectedWork);
    });
  });
}
