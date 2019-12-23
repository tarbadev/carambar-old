import 'package:equatable/equatable.dart';

class SetEndLifeDialogVisibleAction extends Equatable {
  final bool visible;

  SetEndLifeDialogVisibleAction(this.visible);

  @override
  List<Object> get props => [visible];
}
class EndLifeAction extends Equatable {

  @override
  List<Object> get props => [];
}