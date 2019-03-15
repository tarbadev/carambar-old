import 'package:carambar/actions.dart';
import 'package:carambar/store.dart';
import 'package:carambar/ui/presenter/character_presenter.dart';
import 'package:redux/redux.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

List<Middleware<GlobalState>> createStoreMiddleware() => [
  TypedMiddleware<GlobalState, EndLifeAction>(_endLife),
];

Future _endLife(Store<GlobalState> store, EndLifeAction action, NextDispatcher next) async {
  var container = kiwi.Container();
  CharacterPresenter _characterPresenter = container.resolve("characterPresenter");
  await _characterPresenter.endLife();

  next(action);
}