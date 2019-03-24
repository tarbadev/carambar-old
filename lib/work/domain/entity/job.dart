import 'package:equatable/equatable.dart';

class Job extends Equatable {
  final String name;
  final double salary;
  final String requirements;

  Job({this.name, this.requirements, this.salary}): super([name, requirements, salary]);
}