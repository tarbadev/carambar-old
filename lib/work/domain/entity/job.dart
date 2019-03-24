import 'package:equatable/equatable.dart';

enum Requirement { HighSchool, Supervisor3Years, Teacher5Years, Counselor5Years, AssociateDirector5Years }

class Job extends Equatable {
  final int id;
  final String name;
  final double salary;
  final List<Requirement> requirements;

  Job({this.id, this.name, this.requirements, this.salary}): super([id, name, requirements, salary]);
}