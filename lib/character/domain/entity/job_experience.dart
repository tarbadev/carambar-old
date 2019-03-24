import 'package:equatable/equatable.dart';

class JobExperience extends Equatable {
  final String name;
  int experience;

  JobExperience({this.name, this.experience}): super([name, experience]);
}