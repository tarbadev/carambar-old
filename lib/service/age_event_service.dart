import 'package:carambar/domain/entity/age_event.dart';
import 'package:carambar/repository/age_event_repository.dart';

class AgeEventService {
  final AgeEventRepository _ageEventRepository;

  AgeEventService(this._ageEventRepository);

  Future<List<AgeEvent>> getAgeEvents() async {
    return await _ageEventRepository.readAgeEvents() ?? [];
  }

  Future<void> addEvent(int age) async {
    List<AgeEvent> events = await getAgeEvents();
    events.add(AgeEvent(age: age, events: []));

    await _ageEventRepository.save(events);
  }
}