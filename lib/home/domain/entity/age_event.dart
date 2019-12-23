import 'package:equatable/equatable.dart';

class AgeEvent extends Equatable {
  final int age;
  final List<String> events;

  AgeEvent({this.age, this.events});

  @override
  List<Object> get props => [age, events];
}