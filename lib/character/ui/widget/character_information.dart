import 'package:carambar/character/ui/entity/display_character.dart';
import 'package:flutter/material.dart';

class CharacterInformation extends StatelessWidget {
  final DisplayCharacter displayCharacter;

  CharacterInformation({Key key, @required this.displayCharacter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var index = 0;

    return Padding(
        padding: EdgeInsets.all(5),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text(
                      displayCharacter.name,
                      key: Key('Character__Name'),
                      style: Theme.of(context).textTheme.headline,
                    ),
                    Expanded(
                        child: Align(
                            alignment: FractionalOffset.bottomRight,
                            child: Text(
                              displayCharacter.age,
                              key: Key('Character__Age'),
                              style: Theme.of(context).textTheme.title,
                            ))),
                  ],
                ),
              ),
              Row(children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 5),
                  child: Text(
                    displayCharacter.ageCategory,
                    key: Key('Character__AgeCategory'),
                  ),
                ),
                Text(
                  displayCharacter.gender,
                  key: Key('Character__Gender'),
                ),
                Expanded(
                    child: Align(
                        alignment: FractionalOffset.bottomRight,
                        child: Text(
                          displayCharacter.origin,
                          key: Key('Character__Origin'),
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
                    key: Key('Character__School'),
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
                    key: Key('Character__Graduates'),
                    children: displayCharacter.graduates
                        .map((graduate) => Text(
                              graduate,
                              key: Key('Character__graduates__${index++}'),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ]));
  }
}
