import 'package:flutter/material.dart';

part 'program.g.dart';

class Program {
  String id;
  String name;
  int completed;

  Program({@required this.id, this.name, this.completed});

  void toggleCompleted() {
    // completed != !completed;
  }

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$ProgramFromJson()` constructor.
  /// The constructor is named after the source class, in this case User.
  factory Program.fromJson(Map<String, dynamic> json) => _$ProgramFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$ProgramFromJson`.
  Map<String, dynamic> toJson() => _$ProgramToJson(this);
}
