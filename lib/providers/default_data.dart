import 'package:flutter_fitness/models/program.dart';
import 'package:flutter_fitness/models/week.dart';
import 'package:flutter_fitness/models/day.dart';
import 'package:flutter_fitness/models/exercise.dart';
import 'package:flutter_fitness/models/round.dart';

class DefaultData {

  DefaultData._();
  static final DefaultData defaultData = DefaultData._();
 
  var rounds = [
    Round(id:1, weight: 100, round: 1, rep: 1, exerciseId: 1, dayId: 1, weekId: 1, programId: 1),
    Round(id:2, weight: 200, round: 1, rep: 1, exerciseId: 1, dayId: 1, weekId: 1, programId: 1),

    Round(id:3, weight: 10, round: 1, rep: 1, exerciseId: 4, dayId: 8, weekId: 2, programId: 1),
    Round(id:4, weight: 20, round: 1, rep: 1, exerciseId: 4, dayId: 8, weekId: 2, programId: 1),

    // Round( id: 4, weight: 50, round: 4, rep: 16, exerciseId: 4, dayId: 2, weekId: '39811115-7350-47a3-8f89-015e4daf64b8', programId: '1'),
    // Round( id: 5, weight: 60, round: 4, rep: 16, exerciseId: 5, dayId: 2, weekId: '39811115-7350-47a3-8f89-015e4daf64b8', programId: '1'),
    // Round( id: 6, weight: 120, round: 4, rep: 16, exerciseId: 6, dayId: 2, weekId: '39811115-7350-47a3-8f89-015e4daf64b8', programId: '1'),
    
    // Round( id: 7, weight: 100, round: 4, rep: 8, exerciseId: 7, dayId: 3, weekId: '39811115-7350-47a3-8f89-015e4daf64b8', programId: '1'),

    // Round( id: 8, weight: 100, round: 4, rep: 8, exerciseId: 8, dayId: 4, weekId: '39811115-7350-47a3-8f89-015e4daf64b8', programId: '1'),
    // Round( id: 9, weight: 100, round: 4, rep: 8, exerciseId: 9, dayId: 4, weekId: '39811115-7350-47a3-8f89-015e4daf64b8', programId: '1'),
    // Round( id: 10, weight: 60, round: 4, rep: 14, exerciseId: 10, dayId: 4, weekId: '39811115-7350-47a3-8f89-015e4daf64b8', programId: '1'),
    
    // Round( id: 11, weight: 120, round: 4, rep: 11, exerciseId: 11, dayId: 5, weekId: '39811115-7350-47a3-8f89-015e4daf64b8', programId: '1'),
    // Round( id: 12, weight: 50, round: 4, rep: 12, exerciseId: 12, dayId: 5, weekId: '39811115-7350-47a3-8f89-015e4daf64b8', programId: '1'),
  ];

   var exercises = [
    Exercise(id: 1, name: 'Chest Press', currentVolume: 100, dayId: 1, weekId: 1, programId: 1),
    Exercise(id: 2, name: 'Incline Press', currentVolume: 200, dayId: 2, weekId: 1, programId: 1),
    Exercise(id: 3, name: 'Dips', dayId: 3, weekId: 1, programId: 1),

    Exercise(id: 4, name: 'Chest Press', currentVolume: 150, dayId: 8, weekId: 2, programId: 1),
    Exercise(id: 5, name: 'Incline Press', currentVolume: 250, dayId: 9, weekId: 2, programId: 1),
    Exercise(id: 6,name: 'Dips', dayId: 10, weekId: 2, programId: 1),

    Exercise(id: 7, name: 'Chest Press', currentVolume: 200, dayId: 15, weekId: 3, programId: 1),
    Exercise(id: 8, name: 'Incline Press', currentVolume: 300, dayId: 16, weekId: 3, programId: 1),
    Exercise(id: 9, name: 'Dips', dayId: 17, weekId: 3, programId: 1),

    Exercise(id: 10, name: 'Chest Press', currentVolume: 250, dayId: 15, weekId: 4, programId: 1),
    Exercise(id: 11, name: 'Incline Press', currentVolume: 350, dayId: 16, weekId: 4, programId: 1),
    Exercise(id: 12, name: 'Dips', dayId: 17, weekId: 4, programId: 1),

    // Exercise( id: 4, name: 'Lunges', bestVolume: 3200, previousVolume: 0, currentVolume: 3200, round: [], dayId: 2, weekId: '39811115-7350-47a3-8f89-015e4daf64b8', programId: '1'),
    // Exercise( id: 5, name: 'Squat', bestVolume: 3600, previousVolume: 0, currentVolume: 3600, round: [], dayId: 2, weekId: '39811115-7350-47a3-8f89-015e4daf64b8', programId: '1'),
    // Exercise( id: 6, name: 'Deadlift', bestVolume: 7200, previousVolume: 0, currentVolume: 7200, round: [], dayId: 2, weekId: '39811115-7350-47a3-8f89-015e4daf64b8', programId: '1'),

    // Exercise( id: 7, name: 'Abs', bestVolume: 4800, previousVolume: 0, currentVolume: 4800, round: [], dayId: 3, weekId: '39811115-7350-47a3-8f89-015e4daf64b8', programId: '1'),

    // Exercise( id: 8, name: 'Pull-ups', bestVolume: 4800, previousVolume: 0, currentVolume: 4800, round: [], dayId: 4, weekId: '39811115-7350-47a3-8f89-015e4daf64b8', programId: '1'),
    // Exercise( id: 9, name: 'Reverse Pull-ups', bestVolume: 2400, previousVolume: 0, currentVolume: 2400, round: [], dayId: 4, weekId: '39811115-7350-47a3-8f89-015e4daf64b8', programId: '1'),
    // Exercise( id: 10, name: 'Rows', bestVolume: 3120, previousVolume: 0, currentVolume: 3120, round: [], dayId: 4, weekId: '39811115-7350-47a3-8f89-015e4daf64b8', programId: '1'),

    // Exercise( id: 11, name: 'Sitting Press', bestVolume: 4800, previousVolume: 0, currentVolume: 4800, round: [], dayId: 5, weekId: '39811115-7350-47a3-8f89-015e4daf64b8', programId: '1'),
    // Exercise( id: 12, name: ' Standing Press 1.5', bestVolume: 2400, previousVolume: 0, currentVolume: 2400, round: [], dayId: 5, weekId: '39811115-7350-47a3-8f89-015e4daf64b8', programId: '1'),
  ];

  var newDays = [
    Day(id: 1, name: 'Monday', target: 'Chest & Triceps', weekId: 1, programId: 1),
    Day(id: 2, name: 'Tuesday', target: 'Legs', weekId: 1, programId: 1),
    Day(id: 3, name: 'Wednesday', target: 'Abs',  weekId: 1, programId: 1),
    Day(id: 4, name: 'Thursday', target: 'Back & Biceps', weekId: 1, programId: 1),
    Day(id: 5, name: 'Friday', target: 'Shoulder', weekId: 1, programId: 1),
    Day(id: 6, name: 'Saturday', target: 'Day Off',  weekId: 1, programId: 1),
    Day(id: 7, name: 'Sunday', target: 'Day Off',  weekId: 1, programId: 1),

    Day(id: 8, name: 'Monday', target: 'Chest & Triceps', weekId: 2, programId: 1),
    Day(id: 9, name: 'Tuesday', target: 'Legs', weekId: 2, programId: 1),
    Day(id: 10, name: 'Wednesday', target: 'Abs',  weekId: 2, programId: 1),
    Day(id: 11, name: 'Thursday', target: 'Back & Biceps', weekId: 2, programId: 1),
    Day(id: 12, name: 'Friday', target: 'Shoulder', weekId: 2, programId: 1),
    Day(id: 13, name: 'Saturday', target: 'Day Off',  weekId: 2, programId: 1),
    Day(id: 14, name: 'Sunday', target: 'Day Off',  weekId: 2, programId: 1),

    Day(id: 15, name: 'Monday', target: 'Chest & Triceps', weekId: 3, programId: 1),
    Day(id: 16, name: 'Tuesday', target: 'Legs', weekId: 3, programId: 1),
    Day(id: 17, name: 'Wednesday', target: 'Abs',  weekId: 3, programId: 1),
    Day(id: 18, name: 'Thursday', target: 'Back & Biceps', weekId: 3, programId: 1),
    Day(id: 19, name: 'Friday', target: 'Shoulder', weekId: 3, programId: 1),
    Day(id: 20, name: 'Saturday', target: 'Day Off',  weekId: 3, programId: 1),
    Day(id: 21, name: 'Sunday', target: 'Day Off',  weekId: 3, programId: 1),

    Day(id: 22, name: 'Monday', target: 'Chest & Triceps', weekId: 4, programId: 1),
    Day(id: 23, name: 'Tuesday', target: 'Legs', weekId: 4, programId: 1),
    Day(id: 24, name: 'Wednesday', target: 'Abs',  weekId: 4, programId: 1),
    Day(id: 25, name: 'Thursday', target: 'Back & Biceps', weekId: 4, programId: 1),
    Day(id: 26, name: 'Friday', target: 'Shoulder', weekId: 4, programId: 1),
    Day(id: 27, name: 'Saturday', target: 'Day Off',  weekId: 4, programId: 1),
    Day(id: 28, name: 'Sunday', target: 'Day Off',  weekId: 4, programId: 1)

  ];

  var days = [
    Day(name: 'Monday', target: 'Chest & Triceps',),
    Day(name: 'Tuesday', target: 'Legs',),
    Day(name: 'Wednesday', target: 'Abs',),
    Day(name: 'Thursday', target: 'Back & Biceps',),
    Day(name: 'Friday', target: 'Shoulder',),
    Day(name: 'Saturday', target: 'Day Off',),
    Day(name: 'Sunday', target: 'Day Off',)
  ];

  var weeks = [
    Week(id: 1, name: 'Week 1', date: 1601596511000, programId: 1),
    Week(id: 2, name: 'Week 2', date: 1601682911000, programId: 1),
    Week(id: 3, name: 'Week 3', date: 1604278511000, programId: 1),
    Week(id: 4, name: 'Week 4', date: 1606870511000, programId: 1),
    Week(id: 5, name: 'Week 5', date: 1609548911000, programId: 1)
  ];

  var programs = [
    // Program('5 Days Split', id: '1',  color: Colors.purple.value, codePoint: Icons.fitness_center.codePoint),
    // Program('Pull & Push', id: '2', color: Colors.pink.value, codePoint: Icons.fitness_center.codePoint),
    Program(id: 1, name: 'Awesome Program One'),
    // Program(id: 2, name: 'Awesome Program Two')
  ];

}