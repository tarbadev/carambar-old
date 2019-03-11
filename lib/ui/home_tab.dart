import 'package:carambar/domain/entity/age_event.dart';
import 'package:carambar/service/character_service.dart';
import 'package:carambar/service/age_event_service.dart';
import 'package:carambar/ui/widget/age_event_list.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class HomeTab extends StatefulWidget {
  HomeTab({Key key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  CharacterService _characterService;
  AgeEventService _ageEventService;

  @override
  void initState() {
    super.initState();

    var container = kiwi.Container();
    _characterService = container.resolve("characterService");
    _ageEventService = container.resolve("ageEventService");
  }

  void _onAgeButtonClick() async {
    await _characterService.incrementAge();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
            FutureBuilder<List<AgeEvent>>(
                future: _ageEventService.getAgeEvents(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AgeEventList(ageEvents: snapshot.data);
                  } else {
                    return Text("Loading...");
                  }
                }),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: MaterialButton(
                  key: Key("ageButton"),
                  color: Colors.lightBlue,
                  onPressed: _onAgeButtonClick,
                  child: Text(
                    "Age",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ])),
    );
  }
}



