import 'package:carambar/service/character_service.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class HomeTab extends StatefulWidget {
  HomeTab({Key key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  CharacterService _characterService;

  @override
  void initState() {
    super.initState();

    var container = kiwi.Container();
    _characterService = container.resolve("characterService");
  }

  void _onAgeButtonClick() async {
    await _characterService.incrementAge();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: MaterialButton(
                  key: Key("ageButton"),
                  color: Colors.lightBlue,
                  onPressed: _onAgeButtonClick,
                  child: Text("Age", style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ])),
    );
  }
}
