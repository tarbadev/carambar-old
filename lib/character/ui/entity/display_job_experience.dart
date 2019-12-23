import 'package:carambar/character/domain/entity/job_experience.dart';
import 'package:equatable/equatable.dart';

class DisplayJobExperience extends Equatable {
  final String name;
  final String experience;

  DisplayJobExperience({this.name, this.experience});

  static DisplayJobExperience fromJobExperience(JobExperience jobExperience) {
    return DisplayJobExperience(
      name: jobExperience.name,
      experience: '${jobExperience.experience} years',
    );
  }

  @override
  List<Object> get props => [name, experience];
}