import 'package:carambar/domain/entity/character.dart';
import 'package:carambar/service/character_service.dart';
import 'package:carambar/ui/widget/character_information.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class CharacterTab extends StatefulWidget {
  CharacterTab({Key key}) : super(key: key);

  @override
  _CharacterTabState createState() => _CharacterTabState();
}

class _CharacterTabState extends State<CharacterTab> {
  CharacterService _characterService;

  @override
  void initState() {
    super.initState();

    var container = kiwi.Container();
    _characterService = container.resolve("characterService");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<Character>(
          future: _characterService.getCharacter(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CharacterInformation(character: snapshot.data);
            } else {
              return Text("Loading...");
            }
          }),
    );
  }
}
