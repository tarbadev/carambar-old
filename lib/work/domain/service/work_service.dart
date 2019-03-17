import 'package:carambar/work/domain/entity/job.dart';

class WorkService {
  List<Job> getAvailableJobs() {
    return [
      Job(
        name: 'Supervisor',
        requirements: 'High School completed successfully',
      ),
    ];
  }
}
