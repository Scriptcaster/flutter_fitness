import 'package:json_annotation/json_annotation.dart';

part 'day.g.dart';

@JsonSerializable()

class Day {

  int id;
  String name;
  String target;
  int completed;
  int weekId;
  int programId;
  
  Day({ 
    this.id, 
    this.name, 
    this.target,
    this.completed = 0,
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
  /// from a map. Pass the map to the generated `_$DayFromJson()` constructor.
  /// The constructor is named after the source class, in this case User.
  factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$DayFromJson`.
  Map<String, dynamic> toJson() => _$DayToJson(this);

}