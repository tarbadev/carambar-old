import 'package:equatable/equatable.dart';

enum Requirement { HighSchool, Supervisor3Years, SubTeacher1Year, Teacher5Years, Counselor5Years, AssociateDirector5Years }
enum PersonalityTrait { Charismatic, Patient, Benevolent }

class Job extends Equatable {
  final int id;
  final String name;
  final double salary;
  final List<Requirement> requirements;
  final List<PersonalityTrait> personalityTraits;

  Job({this.id, this.name, this.requirements, this.salary, this.personalityTraits: const []});

  @override
  List<Object> get props => [id, name, requirements, salary, personalityTraits];
}
