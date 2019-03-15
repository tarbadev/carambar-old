import 'package:carambar/character/domain/entity/nationality.dart';
import 'package:equatable/equatable.dart';

enum AgeCategory { baby, child, teen, adult }
enum School { None }

class Character extends Equatable {
  final String firstName;
  final String lastName;
  final String gender;
  final Nationality origin;
  int age;
  final School school = School.None;

  AgeCategory get ageCategory {
    if (age >= 18) return AgeCategory.adult;
    else if (age >= 12) return AgeCategory.teen;
    else if (age >= 3) return AgeCategory.child;
    else return AgeCategory.baby;
  }

  Character({this.firstName, this.lastName, this.gender, this.origin, this.age})
      : super([firstName, lastName, gender, origin, age]);
}
