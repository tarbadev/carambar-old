class SelectTabAction {
  final int index;

  SelectTabAction(this.index);
}

class SelectHomeTabAction extends SelectTabAction {
  SelectHomeTabAction() : super(0);
}

class InitiateStateAction {}