import 'package:carambar/application/ui/util/string_utils.dart';
import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/application/domain/entity/nationality.dart';
import 'package:carambar/character/ui/entity/display_current_job.dart';
import 'package:carambar/character/ui/entity/display_job_experience.dart';
import 'package:equatable/equatable.dart';

class DisplayCharacter extends Equatable {
  final String name;
  final String gender;
  final String age;
  final String origin;
  final String ageCategory;
  final DisplayCurrentJob currentJob;
  final List<DisplayJobExperience> jobHistory;

  String get genderChild => gender == 'Male' ? 'Boy' : 'Girl';
  final String school;
  final List<String> graduates;

  DisplayCharacter(
    this.name,
    this.gender,
    this.age,
    this.origin,
    this.ageCategory,
    this.school,
    this.graduates,
    this.currentJob,
    this.jobHistory,
  );

  @override
  List<Object> get props => [name, gender, age, origin, ageCategory, school, graduates, currentJob, jobHistory];

  static DisplayCharacter fromCharacter(Character character) {
    return DisplayCharacter(
      '${StringUtils.capitalize(character.firstName)} ${StringUtils.capitalize(character.lastName)}',
      '${StringUtils.capitalize(character.gender)}',
      '${character.age}',
      _mapNationalityToString[character.origin],
      _mapAgeCategoryToString[character.ageCategory],
      _mapSchoolToDisplaySchool[character.school],
      character.graduates.map((graduate) => _mapSchoolToDisplaySchool[graduate]).toList(),
      DisplayCurrentJob.fromJob(character.currentJob),
      character.jobHistory
          .map((jobExperience) => DisplayJobExperience.fromJobExperience(jobExperience))
          .toList()
          .reversed
          .toList(),
    );
  }

  static final _mapAgeCategoryToString = {
    AgeCategory.adult: 'Adult',
    AgeCategory.teen: 'Teen',
    AgeCategory.child: 'Child',
    AgeCategory.baby: 'Baby',
  };

  static final _mapSchoolToDisplaySchool = {
    School.None: 'None',
    School.Kindergarten: 'Kindergarten',
    School.PrimarySchool: 'Primary School',
    School.MiddleSchool: 'Middle School',
    School.HighSchool: 'High School',
  };

  static final _mapNationalityToString = {
    Nationality.australia: 'Australia',
    Nationality.brazil: 'Brazil',
    Nationality.canada: 'Canada',
    Nationality.switzerland: 'Switzerland',
    Nationality.germany: 'Germany',
    Nationality.denmark: 'Denmark',
    Nationality.spain: 'Spain',
    Nationality.finland: 'Finland',
    Nationality.france: 'France',
    Nationality.unitedKingdom: 'United Kingdom',
    Nationality.ireland: 'Ireland',
    Nationality.iran: 'Iran',
    Nationality.norway: 'Norway',
    Nationality.netherlands: 'Netherlands',
    Nationality.newZealand: 'New Zealand',
    Nationality.turkey: 'Turkey',
    Nationality.unitedStates: 'United States',
  };

  @override
  String toString() {
    return 'DisplayCharacter{name: $name, gender: $gender, age: $age, origin: $origin, ageCategory: $ageCategory, currentJob: $currentJob, jobHistory: $jobHistory, school: $school, graduates: $graduates}';
  }
}
