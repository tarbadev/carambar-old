import 'package:carambar/domain/entity/nationality.dart';
import 'package:equatable/equatable.dart';

enum AgeCategory { baby, child, teen, adult }

class Character extends Equatable {
  final String firstName;
  final String lastName;
  final String sex;
  final Nationality origin;
  int age;

  AgeCategory get ageCategory {
    if (age >= 18) return AgeCategory.adult;
    else if (age >= 12) return AgeCategory.teen;
    else if (age >= 3) return AgeCategory.child;
    else return AgeCategory.baby;
  }

  Character({this.firstName, this.lastName, this.sex, this.origin, this.age})
      : super([firstName, lastName, sex, origin, age]);
}
