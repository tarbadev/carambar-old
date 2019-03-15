import 'package:equatable/equatable.dart';

class SetEndLifeDialogVisibleAction extends Equatable {
  final bool visible;

  SetEndLifeDialogVisibleAction(this.visible): super([visible]);
}
class EndLifeAction extends Equatable {}