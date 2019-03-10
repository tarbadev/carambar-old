import 'package:carambar/domain/entity/character.dart';
import 'package:carambar/ui/presenter/character_presenter.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CharacterInformation extends StatelessWidget {
  CharacterPresenter _characterPresenter;

  CharacterInformation({Key key, Character character}) : super(key: key) {
    _characterPresenter = CharacterPresenter.fromCharacter(character);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _characterPresenter.name,
            key: Key("characterName"),
          ),
          Text(
            _characterPresenter.sex,
            key: Key("characterSex"),
          ),
          Text(
            _characterPresenter.origin,
            key: Key("characterOrigin"),
          ),
          Text(
            _characterPresenter.age,
            key: Key("characterAge"),
          ),
          Text(
            _characterPresenter.ageCategory,
            key: Key("characterAgeCategory"),
          ),
        ]);
  }
}
