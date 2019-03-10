import 'package:carambar/domain/entity/character.dart';
import 'package:carambar/domain/entity/nationality.dart';
import 'package:carambar/ui/util/string_utils.dart';
import 'package:equatable/equatable.dart';

class CharacterPresenter extends Equatable {
  final String name;
  final String sex;
  final String age;
  final String origin;
  final String ageCategory;

  CharacterPresenter(this.name, this.sex, this.age, this.origin, this.ageCategory): super([name, sex, age, origin, ageCategory]);

  static CharacterPresenter fromCharacter(Character character) {
    return CharacterPresenter(
        '${StringUtils.capitalize(character.firstName)} ${StringUtils.capitalize(character.lastName)}',
        '${StringUtils.capitalize(character.sex)}',
        '${character.age}',
        _mapNationalityToString[character.origin],
        _ageCategoryPresenter(character.ageCategory)
    );
  }

  static String _ageCategoryPresenter(AgeCategory ageCategory) {
    if (ageCategory == AgeCategory.baby) {
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