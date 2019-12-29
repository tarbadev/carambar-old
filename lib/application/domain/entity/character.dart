import 'package:carambar/application/domain/entity/initiate_event.dart';
import 'package:carambar/application/domain/entity/job_experience.dart';
import 'package:carambar/application/domain/entity/nationality.dart';
import 'package:carambar/work/domain/entity/job.dart';
import 'package:equatable/equatable.dart';

enum AgeCategory { baby, child, teen, adult }
enum School { None, Kindergarten, PrimarySchool, MiddleSchool, HighSchool }

class Character extends Equatable {
  final String firstName;
  final String lastName;
  final String gender;
  final Nationality origin;
  final List<School> graduates;
  final int age;
  final Job currentJob;
  final List<JobExperience> jobHistory;
  final School school;

  AgeCategory get ageCategory {
    if (age >= 18)
      return AgeCategory.adult;
    else if (age >= 12)
      return AgeCategory.teen;
    else if (age >= 3)
      return AgeCategory.child;
    else
      return AgeCategory.baby;
  }

  Character({
    this.firstName,
    this.lastName,
    this.gender,
    this.origin,
    this.age,
    this.graduates,
    this.currentJob,
    this.jobHistory,
    this.school,
  });

  factory Character.fromInitiateEvent(InitiateEvent initiateEvent) {
    return Character(
      age: 0,
      firstName: initiateEvent.firstName,
      lastName: initiateEvent.lastName,
      gender: initiateEvent.gender,
      origin: initiateEvent.origin,
      graduates: [],
      jobHistory: [],
    );
  }

  @override
  List<Object> get props => [
        firstName,
        lastName,
        gender,
        origin,
        age,
        graduates,
        currentJob,
        jobHistory,
    school,
      ];

  @override
  String toString() {
    return 'Character{firstName: $firstName, lastName: $lastName, gender: $gender, origin: $origin, graduates: $graduates, age: $age, currentJob: $currentJob, jobHistory: $jobHistory, school: $school}';
  }
}
