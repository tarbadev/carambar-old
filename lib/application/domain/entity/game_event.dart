import 'package:equatable/equatable.dart';

class GameEvent extends Equatable {
  final int age;

  GameEvent(this.age);

  @override
  List<Object> get props => [age];
}