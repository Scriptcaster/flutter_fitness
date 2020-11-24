// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercise _$ExerciseFromJson(Map<String, dynamic> json) {
  return Exercise(
    id: json['id'] as int,
    name: json['name'] as String,
    completed: json['completed'] as int,
    bestVolume: json['bestVolume'] as int,
    previousVolume: json['previousVolume'] as int,
    currentVolume: json['currentVolume'] as int,
    dayId: json['dayId'] as int,
    weekId: json['weekId'] as int,
    programId: json['programId'] as int
  );
}

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'completed': instance.completed,
  'bestVolume': instance.bestVolume,
  'previousVolume': instance.previousVolume,
  'currentVolume': instance.currentVolume,
  'dayId': instance.dayId,
  'weekId': instance.weekId,
  'programId': instance.programId
};

