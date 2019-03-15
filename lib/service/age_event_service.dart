import 'package:carambar/domain/entity/age_event.dart';
import 'package:carambar/repository/age_event_repository.dart';

class AgeEventService {
  final AgeEventRepository _ageEventRepository;

  AgeEventService(this._ageEventRepository);

  Future<List<AgeEvent>> getAgeEvents() async {
    return await _ageEventRepository.readAgeEvents() ?? [];
  }

  Future<void> addEvent(int age, {String event}) async {
    List<AgeEvent> events = await getAgeEvents();
    AgeEvent ageEvent = events.firstWhere(
        (existingAgeEvent) => existingAgeEvent.age == age, orElse: () {
      var newAgeEvent = AgeEvent(age: age, events: []);
      events.add(newAgeEvent);
      return newAgeEvent;
    });

    if (event != null) {
      ageEvent.events.add(event);
    }

    await _ageEventRepository.save(events);
  }

  Future<void> deleteAgeEvents() async => await _ageEventRepository.delete();
}