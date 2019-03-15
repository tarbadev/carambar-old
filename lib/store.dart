class GlobalState {
  final int currentTab;

  GlobalState(this.currentTab);

  factory GlobalState.initial() => GlobalState(0);
}