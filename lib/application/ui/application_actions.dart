import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:equatable/equatable.dart';

class SelectTabAction extends Equatable {
  final int index;

  SelectTabAction(this.index);

  @override
  List<Object> get props => [index];
}

class SelectHomeTabAction extends SelectTabAction {
  SelectHomeTabAction() : super(0);
}

class InitiateStateAction extends Equatable {
  @override
  List<Object> get props => [];
}

class SetAvailableCashAction extends Equatable {
  final double cash;

  SetAvailableCashAction(this.cash);

  @override
  List<Object> get props => [cash];
}

class SetGameEventsAction extends Equatable {
  final List<GameEvent> gameEvents;

  SetGameEventsAction(this.gameEvents);

  @override
  List<Object> get props => [gameEvents];

  @override
  String toString() {
    return 'SetGameEventsAction{gameEvents: $gameEvents}';
  }
}

class InitiateCharacterAction extends Equatable {
  @override
  List<Object> get props => [];
}

class BuildAgeEventsAction extends Equatable {
  final List<GameEvent> gameEvents;

  BuildAgeEventsAction(this.gameEvents);

  @override
  List<Object> get props => [gameEvents];
}

class BuildCharacterAction extends Equatable {
  final List<GameEvent> gameEvents;

  BuildCharacterAction(this.gameEvents);

  @override
  List<Object> get props => [gameEvents];
}