import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final String firstName;
  final String lastName;
  final String sex;
  final String origin;
  int age;

  Character({this.firstName, this.lastName, this.sex, this.origin, this.age}) : super([firstName, lastName, sex, origin, age]);
}