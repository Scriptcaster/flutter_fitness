import 'package:flutter/material.dart';
import 'package:flutter_fitness/utils/uuid.dart';
import 'package:flutter_fitness/utils/seq.dart';
import 'package:json_annotation/json_annotation.dart';

part 'week.g.dart';

@JsonSerializable()
class Week {
  int id;
  String name;
  int completed;
  int date;
  int programId;

  // Program({
  //   this.id,
  //   this.name, 
  //   this.completed = 0,
  //   this.date
  // });

  Week({
    this.id,
    this.programId,
    this.name, 
    this.completed = 0,
    int date,
  }) : this.date = date ?? Seq().generateDate();

  

  // Program({
  //   String id,
  //   this.name, 
  //   this.completed = 0,
  // }): 
  // this.id = id ?? Uuid().generateV4();

  // Program({this.name, this.completed}) : this.id = id ?? Uuid().generateV4();

  // Week copy({int id, String name, int completed}) {
  //   return Program(
  //     id ?? this.id,
  //     name: name ?? this.name,
  //     completed: completed ?? this.completed,
  //   );
  // }

  void toggleCompleted() {
    if (completed == 0) {
      completed = 1;
    } else {
      completed = 0;
    }
  }

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$WeekFromJson()` constructor.
  /// The constructor is named after the source class, in this case User.
  factory Week.fromJson(Map<String, dynamic> json) => _$WeekFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$WeekFromJson`.
  Map<String, dynamic> toJson() => _$WeekToJson(this);
}
