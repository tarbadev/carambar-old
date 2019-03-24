import 'package:carambar/work/domain/entity/job.dart';

class WorkService {
  List<Job> getAvailableJobs() {
    return [
      Job(
        id: 1,
        name: 'Supervisor',
        salary: 15000,
        requirements: [Requirement.HighSchool],
      ),
      Job(
        id: 2,
        name: 'Teacher',
        salary: 20000,
        requirements: [Requirement.Supervisor3Years],
      ),
    ];
  }

  Job getJob(int id) {
    return getAvailableJobs().firstWhere((job) => job.id == id);
  }
}
