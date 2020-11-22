// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Day _$DayFromJson(Map<String, dynamic> json) {
  return Day(
    id: json['id'] as int,
    name: json['name'] as String,
    target: json['target'] as String,
    completed: json['completed'] as int,
    weekId: json['weekId'] as int,
    programId: json['programId'] as int
  );
}

Map<String, dynamic> _$DayToJson(Day instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'target': instance.target,
  'completed': instance.completed,
  'weekId': instance.weekId,
  'programId': instance.programId
};

