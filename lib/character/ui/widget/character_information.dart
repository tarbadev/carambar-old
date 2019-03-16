import 'package:carambar/character/ui/entity/display_character.dart';
import 'package:flutter/material.dart';

class CharacterInformation extends StatelessWidget {
  final DisplayCharacter displayCharacter;

  CharacterInformation({Key key, @required this.displayCharacter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var index = 0;

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
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        displayCharacter.name,
                        key: Key('characterName'),
                        style: Theme.of(context).textTheme.headline,
                      ),
                      Expanded(
                          child: Align(
                              alignment: FractionalOffset.bottomRight,
                              child: Text(
                                displayCharacter.age,
                                key: Key('characterAge'),
                                style: Theme.of(context).textTheme.title,
                              ))),
                    ],
                  ),
                  Row(children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 5),
                      child: Text(
                        displayCharacter.ageCategory,
                        key: Key('characterAgeCategory'),
                      ),
                    ),
                    Text(
                      displayCharacter.gender,
                      key: Key('characterGender'),
                    ),
                    Expanded(
                        child: Align(
                            alignment: FractionalOffset.bottomRight,
                            child: Text(
                              displayCharacter.origin,
                              key: Key('characterOrigin'),
                            )))
                  ]),
                  Divider(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 5),
                        child: Text(
                          'School',
                          style: Theme.of(context).textTheme.subhead,
                        ),
                      ),
                      Text(
                        displayCharacter.school,
                        key: Key('characterSchool'),
                      )
                    ],
                  ),
                  Divider(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 5),
                        child: Text(
                          'Graduates',
                          style: Theme.of(context).textTheme.subhead,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        key: Key('characterGraduates'),
                        children: displayCharacter.graduates
                            .map((graduate) => Text(
                                  graduate,
                                  key: Key('Character__graduates__${index++}'),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ])));
  }
}
