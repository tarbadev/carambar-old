import 'package:carambar/domain/entity/character.dart';
import 'package:carambar/service/character_service.dart';
import 'package:carambar/ui/widget/character_information.dart';
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
    setState(() => {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
            FutureBuilder<Character>(
                future: _characterService.getCharacter(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CharacterInformation(character: snapshot.data);
                  } else {
                    return Text("Loading...");
                  }
                }),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: MaterialButton(
                  key: Key("ageButton"),
                  onPressed: _onAgeButtonClick,
                  child: Text("Age"),
                ),
              ),
            ),
          ])),
    );
  }
}
