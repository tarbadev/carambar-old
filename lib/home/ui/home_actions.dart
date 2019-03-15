import 'package:carambar/home/ui/entity/display_age_event.dart';
import 'package:equatable/equatable.dart';

class SetAgeEventsAction extends Equatable {
  final List<DisplayAgeEvent> displayAgeEvents;

  SetAgeEventsAction(this.displayAgeEvents): super([displayAgeEvents]);
}

class IncrementAgeAction extends Equatable {}