import 'package:carambar/domain/entity/character.dart';
import 'package:carambar/service/character_service.dart';
import 'package:carambar/ui/util/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class HomeTab extends StatefulWidget {
  HomeTab({Key key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  CharacterService _characterService;
  Character _character;

  _HomeTabState() {
    var container = kiwi.Container();
    _characterService = container.resolve("characterService");
    _characterService.getCharacter().then((Character character) => setState(() {
          _character = character;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${StringUtils.capitalize(_character?.firstName)} ${StringUtils.capitalize(_character?.lastName)}',
              key: Key("characterName"),
            ),
            Text(
              '${StringUtils.capitalize(_character?.sex)}',
              key: Key("characterSex"),
            ),
            Text(
              '${StringUtils.capitalize(_character?.origin)}',
              key: Key("characterOrigin"),
            ),
            Text(
              '${_character?.age}',
              key: Key("characterAge"),
            ),
          ],
        ),
      ),
    );
  }
}
