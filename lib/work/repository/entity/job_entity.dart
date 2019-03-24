import 'package:carambar/work/domain/entity/job.dart';

class JobEntity {
  final int id;
  final String name;
  final double salary;
  final List<String> requirements;

  JobEntity({this.id, this.name, this.salary, this.requirements});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'salary': salary,
        'requirements': requirements,
      };

  JobEntity.fromJob(Job job)
      : id = job.id,
        name = job.name,
        salary = job.salary,
        requirements = job.requirements.map((requirement) => requirement.toString()).toList();

  static fromJson(Map<String, dynamic> jsonData) {
    if (jsonData == null) {
      return null;
    }

    return JobEntity(
      id: jsonData['id'],
      name: jsonData['name'],
      salary: jsonData['salary'],
      requirements: List.from(jsonData['requirements']),
    );
  }

  Job toJob() => Job(
        id: id,
        name: name,
        salary: salary,
        requirements: requirements
            .map((requirement) => Requirement.values.firstWhere((e) => e.toString() == requirement))
            .toList(),
      );
}
