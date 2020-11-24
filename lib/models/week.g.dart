// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Week _$WeekFromJson(Map<String, dynamic> json) {
  return Week(
    id: json['id'] as int,
    seq: json['seq'] as int,
    name: json['name'] as String,
    completed: json['completed'] as int,
    date: json['date'] as int,
    programId: json['programId'] as int,
  );
}

Map<String, dynamic> _$WeekToJson(Week instance) => <String, dynamic>{
  'id': instance.id,
  'seq': instance.seq,
  'name': instance.name,
  'completed': instance.completed,
  'date': instance.date,
  'programId': instance.programId,
};
