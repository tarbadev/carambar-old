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
        personalityTraits: [PersonalityTrait.Patient, PersonalityTrait.Benevolent],
      ),
      Job(
        id: 3,
        name: 'Counselor',
        salary: 25000,
        requirements: [Requirement.Teacher5Years],
      ),
      Job(
        id: 4,
        name: 'Associate Director',
        salary: 35000,
        requirements: [Requirement.Counselor5Years],
        personalityTraits: [PersonalityTrait.Charismatic],
      ),
      Job(
        id: 5,
        name: 'Director',
        salary: 50000,
        requirements: [Requirement.AssociateDirector5Years],
        personalityTraits: [PersonalityTrait.Charismatic],
      ),
    ];
  }

  Job getJob(int id) {
    return getAvailableJobs().firstWhere((job) => job.id == id);
  }
}
