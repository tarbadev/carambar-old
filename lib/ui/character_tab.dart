import 'package:carambar/domain/entity/character.dart';
import 'package:carambar/service/character_service.dart';
import 'package:carambar/ui/presenter/character_presenter.dart';
import 'package:carambar/ui/presenter/display_character.dart';
import 'package:carambar/ui/widget/character_information.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class CharacterTab extends StatefulWidget {
  CharacterTab({Key key}) : super(key: key);

  @override
  _CharacterTabState createState() => _CharacterTabState();
}

class _CharacterTabState extends State<CharacterTab> {
  CharacterPresenter _characterPresenter;

  @override
  void initState() {
    super.initState();

    var container = kiwi.Container();
    _characterPresenter = container.resolve("characterPresenter");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<DisplayCharacter>(
          future: _characterPresenter.getDisplayCharacter(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CharacterInformation(displayCharacter: snapshot.data);
            } else {
              return Text("Loading...");
            }
          }),
    );
  }
}
