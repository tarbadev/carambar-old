import 'package:carambar/application/domain/entity/game_event.dart';

class AddCashEvent extends GameEvent {
  final double amount;

  AddCashEvent(int age, this.amount) : super(age);

  @override
  List<Object> get props => [age, amount];
}