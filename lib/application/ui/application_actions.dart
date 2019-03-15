import 'package:equatable/equatable.dart';

class SelectTabAction extends Equatable {
  final int index;

  SelectTabAction(this.index): super([index]);
}

class SelectHomeTabAction extends SelectTabAction {
  SelectHomeTabAction() : super(0);
}

class InitiateStateAction extends Equatable {}