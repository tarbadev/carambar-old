class SelectTabAction {
  final int index;

  SelectTabAction(this.index);
}

class EndLifeAction {}

class SelectHomeTabAction extends SelectTabAction {
  SelectHomeTabAction() : super(0);
}