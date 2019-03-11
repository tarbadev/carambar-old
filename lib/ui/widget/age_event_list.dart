import 'package:carambar/domain/entity/age_event.dart';
import 'package:flutter/material.dart';

class AgeEventList extends StatelessWidget {
  final List<AgeEvent> ageEvents;

  const AgeEventList({Key key, this.ageEvents}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<AgeEventItem> ageEventItems = ageEvents.map((ageEvent) => AgeEventItem(ageEvent: ageEvent)).toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      key: Key('ageEventList'),
      children: ageEventItems,
    );
  }
}

class AgeEventItem extends StatelessWidget {
  final AgeEvent ageEvent;

  const AgeEventItem({Key key, this.ageEvent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String baseKey = 'AgeEventItem__${ageEvent.age}';
    return Card(
      key: Key(baseKey),
        child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[Text('Age ${ageEvent.age}', textScaleFactor: 1.5, key: Key('${baseKey}__age'),)],
                )
              ],
            )));
  }
}
