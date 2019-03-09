import 'package:carambar/domain/entity/character.dart';
import 'package:carambar/ui/util/string_utils.dart';
import 'package:flutter/material.dart';

class CharacterInformation extends StatelessWidget {
  final Character character;

  CharacterInformation({Key key, this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${StringUtils.capitalize(character.firstName)} ${StringUtils.capitalize(character.lastName)}',
            key: Key("characterName"),
          ),
          Text(
            '${StringUtils.capitalize(character.sex)}',
            key: Key("characterSex"),
          ),
          Text(
            '${StringUtils.capitalize(character.origin)}',
            key: Key("characterOrigin"),
          ),
          Text(
            '${character.age}',
            key: Key("characterAge"),
          ),
        ]);
  }
}
