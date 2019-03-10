import 'package:carambar/domain/entity/nationality.dart';
import 'package:equatable/equatable.dart';

enum AgeCategory { baby }

class Character extends Equatable {
  final String firstName;
  final String lastName;
  final String sex;
  final Nationality origin;
  int age;

  AgeCategory get ageCategory {
    return AgeCategory.baby;
  }

  Character({this.firstName, this.lastName, this.sex, this.origin, this.age})
      : super([firstName, lastName, sex, origin, age]);
}
