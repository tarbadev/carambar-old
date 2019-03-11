import 'package:equatable/equatable.dart';

class AgeEventView extends Equatable {
  final int age;
  final List<String> events;

  AgeEventView(this.age, this.events) : super([age, events]);
}