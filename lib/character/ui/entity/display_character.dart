import 'package:carambar/character/domain/entity/character.dart';
import 'package:carambar/character/domain/entity/nationality.dart';
import 'package:carambar/application/ui/util/string_utils.dart';
import 'package:equatable/equatable.dart';

class DisplayCharacter extends Equatable {
  final String name;
  final String gender;
  final String age;
  final String origin;
  final String ageCategory;
  String get genderChild => gender == "Male" ? "Boy" : "Girl";

  DisplayCharacter(this.name, this.gender, this.age, this.origin, this.ageCategory): super([name, gender, age, origin, ageCategory]);


  static DisplayCharacter fromCharacter(Character character) {
    return DisplayCharacter(
        '${StringUtils.capitalize(character.firstName)} ${StringUtils.capitalize(character.lastName)}',
        '${StringUtils.capitalize(character.gender)}',
        '${character.age}',
        _mapNationalityToString[character.origin],
        _ageCategoryPresenter(character.ageCategory)
    );
  }

  static String _ageCategoryPresenter(AgeCategory ageCategory) {
    switch (ageCategory) {
      case AgeCategory.adult:
        return 'Adult';
        break;
      case AgeCategory.teen:
        return 'Teen';
        break;
      case AgeCategory.child:
        return 'Child';
        break;
      default:
        return 'Baby';
    }
  }

  static final _mapNationalityToString = {
    Nationality.australia: "Australia",
    Nationality.brazil: "Brazil",
    Nationality.canada: "Canada",
    Nationality.switzerland: "Switzerland",
    Nationality.germany: "Germany",
    Nationality.denmark: "Denmark",
    Nationality.spain: "Spain",
    Nationality.finland: "Finland",
    Nationality.france: "France",
    Nationality.unitedKingdom: "United Kingdom",
    Nationality.ireland: "Ireland",
    Nationality.iran: "Iran",
    Nationality.norway: "Norway",
    Nationality.netherlands: "Netherlands",
    Nationality.newZealand: "New Zealand",
    Nationality.turkey: "Turkey",
    Nationality.unitedStates: "United States",
  };
}