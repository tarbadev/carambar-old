import 'package:equatable/equatable.dart';

class JobExperience extends Equatable {
  final String name;
  final int experience;

  JobExperience({this.name, this.experience});

  @override
  List<Object> get props => [name, experience];
}