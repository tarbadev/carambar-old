import 'package:equatable/equatable.dart';

class Job extends Equatable {
  final String name;
  final String requirements;

  Job({this.name, this.requirements}): super([name, requirements]);
}