import 'package:carambar/work/domain/service/work_service.dart';
import 'package:test_api/test_api.dart';

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
