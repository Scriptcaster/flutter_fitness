// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Program _$ProgramFromJson(Map<String, dynamic> json) {
  return Program(
    id: json['id'] as int,
    name: json['name'] as String,
    completed: json['completed'] as int,
    date: json['date'] as int
  );
}

Map<String, dynamic> _$ProgramToJson(Program instance) => <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'completed': instance.completed,
    'date': instance.date,
  };
