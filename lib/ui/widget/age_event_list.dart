import 'package:carambar/ui/entity/display_age_event.dart';
import 'package:flutter/material.dart';

class AgeEventList extends StatelessWidget {
  final List<DisplayAgeEvent> displayAgeEvents;

  const AgeEventList({Key key, this.displayAgeEvents}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ageEventItems = displayAgeEvents
        .map((ageEvent) => AgeEventItem(displayAgeEvent: ageEvent))
        .toList();

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
    var index = 0;
    final events = displayAgeEvent.events.isEmpty ? <Widget>[] : displayAgeEvent.events
        .map((event) => event.split('\n'))
        .reduce((l1, l2) => l1..addAll(l2))
        .map((event) => Padding(
            padding: EdgeInsets.only(bottom: 1, top: 1),
            child: Text(event, key: Key('${baseKey}__events__${index++}'))))
        .toList();
    return Card(
        key: Key(baseKey),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      displayAgeEvent.age,
                      key: Key('${baseKey}__age'),
                      textScaleFactor: 1.5,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.ltr,
                    key: Key('${baseKey}__events'),
                    children: events,
                  ),
                ),
              ],
            )));
  }
}
