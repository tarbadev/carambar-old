import 'package:carambar/character/ui/entity/display_character.dart';
import 'package:flutter/material.dart';

class CharacterInformation extends StatelessWidget {
  final DisplayCharacter displayCharacter;

  CharacterInformation({Key key, @required this.displayCharacter}) : super(key: key);

  factory CharacterInformation.forDesignTime() {
    return CharacterInformation(
        displayCharacter: DisplayCharacter(
      'John Doe',
      'Male',
      '46',
      'United States',
      'Adult',
      'None',
      [],
      null,
      [],
    ));
  }

  @override
  Widget build(BuildContext context) {
    var index = 0;
    var jobHistory = displayCharacter.jobHistory.map((jobExperience) {
      var baseKey = 'JobHistoryItem__${index++}';
      return Row(
        key: Key(baseKey),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(jobExperience.name, key: Key('${baseKey}__name')),
          Text(jobExperience.experience, key: Key('${baseKey}__experience')),
        ],
      );
    }).toList();

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
              Divider(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Current job',
                    style: Theme.of(context).textTheme.subhead,
                  ),
                  Text(
                    'Salary',
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    displayCharacter.currentJob.name,
                    key: Key('Character__Job'),
                  ),
                  Text(
                    displayCharacter.currentJob.salary,
                    key: Key('Character__Salary'),
                  ),
                ],
              ),
              Divider(height: 8),
              Text(
                'Job history',
                style: Theme.of(context).textTheme.subhead,
              ),
              Column(
                children: jobHistory,
              ),
            ]));
  }
}
