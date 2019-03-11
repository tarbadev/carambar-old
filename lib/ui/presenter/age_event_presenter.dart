import 'package:carambar/service/age_event_service.dart';
import 'package:carambar/ui/presenter/display_age_event.dart';

class AgeEventPresenter {
  final AgeEventService _ageEventService;

  AgeEventPresenter(this._ageEventService);

  Future<List<DisplayAgeEvent>> getDisplayAgeEvents() async {
    var ageEvents = await _ageEventService.getAgeEvents();
    return ageEvents.map((ageEvent) => DisplayAgeEvent.fromAgeEvent(ageEvent)).toList();
  }
}