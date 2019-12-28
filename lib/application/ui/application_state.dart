import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:carambar/home/ui/entity/display_age_event.dart';
import 'package:carambar/work/ui/entity/display_job.dart';

class ApplicationState {
  final int currentTab;
  final Character character;
  final List<DisplayAgeEvent> ageEvents;
  final bool isEndLifeDialogVisible;
  final double availableCash;
  final List<DisplayJob> availableJobs;
  final List<GameEvent> gameEvents;

  ApplicationState(
    this.currentTab,
    this.character,
    this.ageEvents,
    this.isEndLifeDialogVisible,
    this.availableCash,
    this.availableJobs,
    this.gameEvents,
  );

  factory ApplicationState.initial() => ApplicationState(0, null, [], false, 0, [], []);
}
