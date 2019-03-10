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
    return Card(
        elevation: 2,
        child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        _characterPresenter.name,
                        key: Key("characterName"),
                        textScaleFactor: 2,
                      ),
                      Expanded(
                          child: Align(
                              alignment: FractionalOffset.bottomRight,
                              child: Text(
                                _characterPresenter.age,
                                key: Key("characterAge"),
                                textScaleFactor: 1.5,
                              ))),
                    ],
                  ),
                  Row(children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 5),
                      child: Text(
                        _characterPresenter.ageCategory,
                        key: Key("characterAgeCategory"),
                      ),
                    ),
                    Text(
                      _characterPresenter.sex,
                      key: Key("characterSex"),
                    ),
                    Expanded(
                        child: Align(
                            alignment: FractionalOffset.bottomRight,
                            child: Text(
                              _characterPresenter.origin,
                              key: Key("characterOrigin"),
                            )))
                  ]),
                ])));
  }
}
