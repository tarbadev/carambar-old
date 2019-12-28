import 'package:carambar/home/domain/entity/age_event.dart';
import 'package:carambar/home/repository/age_event_repository.dart';

class AgeEventService {
  final AgeEventRepository _ageEventRepository;

  AgeEventService(this._ageEventRepository);

  Future<List<AgeEvent>> getAgeEvents() async {
    return await _ageEventRepository.readAgeEvents() ?? List();
  }

  Future<List<AgeEvent>> addEvent(int age, {String event}) async {
    List<AgeEvent> events = await getAgeEvents();
    AgeEvent ageEvent = events.firstWhere(
      (existingAgeEvent) => existingAgeEvent.age == age,
      orElse: () {
        var newAgeEvent = AgeEvent.fromAge(age);
        events.add(newAgeEvent);
        return newAgeEvent;
      },
    );

    if (event != null) {
      ageEvent.events.add(event);
    }

    await _ageEventRepository.save(events);

    return events;
  }

  Future<void> deleteAgeEvents() async => await _ageEventRepository.delete();

  Future<List<AgeEvent>> addEvents(int age, List<String> newEvents) async {
    List<AgeEvent> events = await getAgeEvents();
    AgeEvent ageEvent = events.firstWhere(
          (existingAgeEvent) => existingAgeEvent.age == age,
      orElse: () {
        var newAgeEvent = AgeEvent.fromAge(age);
        events.add(newAgeEvent);
        return newAgeEvent;
      },
    );

    if (newEvents != null) {
      ageEvent.events.addAll(newEvents);
    }

    await _ageEventRepository.save(events);

    return events;
  }
}
