import 'package:json_annotation/json_annotation.dart';

import 'round.dart';

part 'exercise.g.dart';

@JsonSerializable()

class Exercise {

  int id;
  String name;
  int completed;
  int bestVolume;
  int previousVolume;
  int currentVolume;
  // List<Round> round;
  int dayId;
  int weekId; 
  int programId; 
  
  Exercise({ 
    this.id,
    this.name,
    this.completed = 0,
    this.bestVolume = 0,
    this.previousVolume = 0,
    this.currentVolume = 0,
    // this.round,
    this.dayId,
    this.weekId,
    this.programId
  });



  // static final columns = [
  //   'id', 
  //   'dayName', 
  //   'target', 
  //   'completed',  
  //   'weekId', 
  //   'programId'
  // ];

  void toggleCompleted() {
    if (completed == 0) {
      completed = 1;
    } else {
      completed = 0;
    }
  }


  // Map toMap() {
  //   Map map = {
  //     "dayName": dayName,
  //     "target": target,
  //     "weekId": weekId,
  //   };
  //   if (id != null) {
  //     map["id"] = id;
  //   }
  //   return map;
  // }

  //  Map<String, dynamic> toMap() => {
  //   "name": name,
  //   "target": target,
  //   "isCompleted": isCompleted,
  //   // "exercise": exercise,
  //   "weekId": weekId,
  //   "programId": programId,
  // };

  // static fromMap(Map map) {
  //   Day day = new Day();
  //   day.id = map["id"];
  //   day.dayName = map["dayName"];
  //   day.weekId = map["weekId"];
  //   return day;
  // }

  // factory Day.fromMap(Map<String, dynamic> json) => new Day(
  //   id: json["id"],
  //   dayName: json["dayName"],
  //   target: json["target"],
  //   isCompleted: json['isCompleted'],
  //   // exercise: json["exercise"],
  //   weekId: json["weekId"],
  //   programId: json["programId"],
  // );

  //  Day copy({int id, String dayName, String target, int isCompleted, int weekId, int programId}) {
  //   return Day(
  //     id: id ?? this.id,
  //     dayName: dayName ?? this.dayName,
  //     target: target ?? this.target,
  //     isCompleted: isCompleted ?? this.isCompleted,
  //     weekId: weekId ?? this.weekId,
  //     programId: programId ?? this.programId,
  //   );
  // }

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$ExerciseFromJson()` constructor.
  /// The constructor is named after the source class, in this case User.
  factory Exercise.fromJson(Map<String, dynamic> json) => _$ExerciseFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$ExerciseFromJson`.
  Map<String, dynamic> toJson() => _$ExerciseToJson(this);

}