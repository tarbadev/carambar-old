import 'package:carambar/work/domain/entity/job.dart';

class WorkService {
  List<Job> getAvailableJobs() {
    return [
      Job(
        name: 'Supervisor',
        salary: 15000,
        requirements: 'High School completed successfully',
      ),
    ];
  }
}
