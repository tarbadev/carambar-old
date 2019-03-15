import 'package:carambar/character/ui/character_actions.dart';
import 'package:carambar/character/ui/entity/display_character.dart';
import 'package:redux/redux.dart';

final Reducer<DisplayCharacter> setCharacterReducer = combineReducers([
  TypedReducer<DisplayCharacter, SetCharacterAction>(_setCharacter),
]);

DisplayCharacter _setCharacter(DisplayCharacter currentDisplayCharacter, SetCharacterAction action) => action.displayCharacter;