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

class AddAvailableCashAction extends Equatable {
  final double cash;

  AddAvailableCashAction(this.cash);

  @override
  List<Object> get props => [cash];
}

class SetAvailableCashAction extends Equatable {
  final double cash;

  SetAvailableCashAction(this.cash);

  @override
  List<Object> get props => [cash];
}