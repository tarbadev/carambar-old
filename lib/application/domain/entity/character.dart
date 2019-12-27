import 'package:carambar/application/domain/entity/job_experience.dart';
import 'package:carambar/application/domain/entity/current_job.dart';
import 'package:carambar/application/domain/entity/nationality.dart';
import 'package:equatable/equatable.dart';

enum AgeCategory { baby, child, teen, adult }
enum School { None, Kindergarten, PrimarySchool, MiddleSchool, HighSchool }
enum Graduate { MiddleSchool, HighSchool }

class Character extends Equatable {
  final String firstName;
  final String lastName;
  final String gender;
  final Nationality origin;
  final List<Graduate> graduates;
  final int age;
  final CurrentJob currentJob;
  final List<JobExperience> jobHistory;

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

  School get school {
    if (age >= 18)
      return School.None;
    else if (age >= 15)
      return School.HighSchool;
    else if (age >= 11)
      return School.MiddleSchool;
    else if (age >= 6)
      return School.PrimarySchool;
    else if (age >= 3)
      return School.Kindergarten;
    else
      return School.None;
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
  });

  @override
  List<Object> get props => [
        firstName,
        lastName,
        gender,
        origin,
        age,
        graduates,
        currentJob,
        jobHistory
      ];

  Character grow() {
    return Character(
        firstName: this.firstName,
        lastName: this.lastName,
        gender: this.gender,
        origin: this.origin,
        age: this.age + 1,
        graduates: this.graduates,
        currentJob: this.currentJob,
        jobHistory: this.jobHistory);
  }
}
