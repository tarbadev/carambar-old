import 'package:carambar/application/ui/util/string_utils.dart';
import 'package:carambar/character/domain/entity/character.dart';
import 'package:carambar/character/domain/entity/nationality.dart';
import 'package:carambar/character/ui/entity/display_job_experience.dart';
import 'package:carambar/work/ui/entity/display_job.dart';
import 'package:equatable/equatable.dart';

class DisplayCharacter extends Equatable {
  final String name;
  final String gender;
  final String age;
  final String origin;
  final String ageCategory;
  final DisplayJob job;
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
    this.job,
    this.jobHistory,
  ) : super([name, gender, age, origin, ageCategory, school, graduates, job, jobHistory]);

  static DisplayCharacter fromCharacter(Character character) {
    return DisplayCharacter(
      '${StringUtils.capitalize(character.firstName)} ${StringUtils.capitalize(character.lastName)}',
      '${StringUtils.capitalize(character.gender)}',
      '${character.age}',
      _mapNationalityToString[character.origin],
      _mapAgeCategoryToString[character.ageCategory],
      _mapSchoolToDisplaySchool[character.school],
      character.graduates.map((graduate) => _mapGraduateToDisplayGraduate[graduate]).toList(),
      DisplayJob.fromJob(character.job),
      character.jobHistory.map((jobExperience) => DisplayJobExperience.fromJobExperience(jobExperience)).toList().reversed.toList(),
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

  static final _mapGraduateToDisplayGraduate = {
    Graduate.MiddleSchool: 'Middle School',
    Graduate.HighSchool: 'High School',
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
}
