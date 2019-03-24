import 'package:carambar/character/domain/entity/nationality.dart';
import 'package:carambar/work/domain/entity/job.dart';
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
  int age;
  Job job;

  AgeCategory get ageCategory {
    if (age >= 18) return AgeCategory.adult;
    else if (age >= 12) return AgeCategory.teen;
    else if (age >= 3) return AgeCategory.child;
    else return AgeCategory.baby;
  }

  School get school {
    if (age >= 18) return School.None;
    else if (age >= 15) return School.HighSchool;
    else if (age >= 11) return School.MiddleSchool;
    else if (age >= 6) return School.PrimarySchool;
    else if (age >= 3) return School.Kindergarten;
    else return School.None;
  }

  Character({this.firstName, this.lastName, this.gender, this.origin, this.age, this.graduates, this.job})
      : super([firstName, lastName, gender, origin, age, graduates, job]);
}
