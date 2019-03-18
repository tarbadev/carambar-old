import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/character/ui/entity/display_character.dart';
import 'package:carambar/character/ui/widget/character_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class CharacterTab extends StatelessWidget {
  CharacterTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<ApplicationState, _CharacterTabModel>(
      converter: (Store<ApplicationState> store) => _CharacterTabModel.create(store),
      builder: (BuildContext context, _CharacterTabModel viewModel) => Container(
          child: viewModel.displayCharacter != null
              ? CharacterInformation(displayCharacter: viewModel.displayCharacter)
              : Text('Loading...')),
    );
  }
}

class _CharacterTabModel {
  final DisplayCharacter displayCharacter;

  _CharacterTabModel(this.displayCharacter);

  factory _CharacterTabModel.create(Store<ApplicationState> store) => _CharacterTabModel(
        store.state.character,
      );
}
