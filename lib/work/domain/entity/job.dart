import 'package:equatable/equatable.dart';

class Job extends Equatable {
  final int id;
  final String name;
  final double salary;
  final String requirements;

  Job({this.id, this.name, this.requirements, this.salary}): super([id, name, requirements, salary]);
}