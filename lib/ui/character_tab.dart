import 'package:carambar/global_state.dart';
import 'package:carambar/ui/entity/display_character.dart';
import 'package:carambar/ui/widget/character_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class CharacterTab extends StatelessWidget {
  CharacterTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<GlobalState, _CharacterTabModel>(
      converter: (Store<GlobalState> store) => _CharacterTabModel.create(store),
      builder: (BuildContext context, _CharacterTabModel viewModel) => Container(
          child: viewModel.displayCharacter != null
              ? CharacterInformation(displayCharacter: viewModel.displayCharacter)
              : Text("Loading...")),
    );
  }
}

class _CharacterTabModel {
  final DisplayCharacter displayCharacter;

  _CharacterTabModel(this.displayCharacter);

  factory _CharacterTabModel.create(Store<GlobalState> store) => _CharacterTabModel(
        store.state.character,
      );
}
