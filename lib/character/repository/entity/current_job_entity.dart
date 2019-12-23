import 'package:carambar/character/domain/entity/current_job.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'current_job_entity.g.dart';

@JsonSerializable(nullable: true)
class CurrentJobEntity extends Equatable {
  final int id;
  final String name;
  final double salary;

  CurrentJobEntity(this.id, this.name, this.salary);

  factory CurrentJobEntity.fromCurrentJob(CurrentJob currentJob) =>
      CurrentJobEntity(currentJob.id, currentJob.name, currentJob.salary);

  CurrentJob toCurrentJob() => CurrentJob(
    id: id,
    name: name,
    salary: salary,
  );

  factory CurrentJobEntity.fromJson(Map<String, dynamic> jsonData) => _$CurrentJobEntityFromJson(jsonData);
  Map<String, dynamic> toJson() => _$CurrentJobEntityToJson(this);

  @override
  List<Object> get props => [id, name, salary];
}