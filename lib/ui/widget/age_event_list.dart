import 'package:carambar/ui/presenter/display_age_event.dart';
import 'package:flutter/material.dart';

class AgeEventList extends StatelessWidget {
  final List<DisplayAgeEvent> displayAgeEvents;

  const AgeEventList({Key key, this.displayAgeEvents}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<AgeEventItem> ageEventItems =
        displayAgeEvents.map((ageEvent) => AgeEventItem(displayAgeEvent: ageEvent)).toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      key: Key('ageEventList'),
      children: ageEventItems,
    );
  }
}

class AgeEventItem extends StatelessWidget {
  final DisplayAgeEvent displayAgeEvent;

  const AgeEventItem({Key key, this.displayAgeEvent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String baseKey = 'AgeEventItem__${displayAgeEvent.id}';
    return Card(
        key: Key(baseKey),
        child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      displayAgeEvent.age,
                      textScaleFactor: 1.5,
                      key: Key('${baseKey}__age'),
                    )
                  ],
                )
              ],
            )));
  }
}
