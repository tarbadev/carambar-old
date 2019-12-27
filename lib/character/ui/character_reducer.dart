import 'package:carambar/character/domain/entity/character.dart';
import 'package:carambar/character/ui/character_actions.dart';
import 'package:redux/redux.dart';

final Reducer<Character> setCharacterReducer = combineReducers([
  TypedReducer<Character, SetCharacterAction>(_setCharacter),
]);

Character _setCharacter(Character currentCharacter, SetCharacterAction action) => action.character;