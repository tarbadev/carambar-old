import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final String firstName;
  final String lastName;
  final String sex;
  final String origin;

  Character({this.firstName, this.lastName, this.sex, this.origin}) : super([firstName, lastName, sex, origin]);
}