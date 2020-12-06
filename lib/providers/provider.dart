import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_fitness/models/program.dart';
import 'package:flutter_fitness/models/round.dart';
import 'package:flutter_fitness/models/subscriber_series.dart';
import '../models/day.dart';
import '../models/exercise.dart';
import '../models/week.dart';
import 'database.dart';
import 'package:flutter_fitness/providers/default_data.dart';

import 'package:charts_flutter/flutter.dart' as charts;

class TodosModel extends ChangeNotifier {
  var _db = DBProvider.db;

  List<Program> _programs = [];
  List<Week> _weeks = [];
  List<Day> _days = [];
  List<Exercise> _exercises = [];
  List<Round> _rounds = [];

  UnmodifiableListView<Program> get allPrograms => UnmodifiableListView(_programs);
  UnmodifiableListView<Week> get allWeeks => UnmodifiableListView(_weeks);
  UnmodifiableListView<Day> get allDays => UnmodifiableListView(_days);
  UnmodifiableListView<Exercise> get allExercises => UnmodifiableListView(_exercises);
  UnmodifiableListView<Round> get allRounds => UnmodifiableListView(_rounds);

  bool get isLoading => _isLoading;

  bool _isLoading = false;

  List<Program> get programs => _programs.toList();
  List<Week> get weeks => _weeks.toList();
  List<Day> get days => _days.toList();
  List<Exercise> get exercises => _exercises.toList();
  List<Round> get rounds => _rounds.toList();

  void getPrograms() async {
   var isNew = !await DBProvider.db.dbExists();
    if (isNew) {
      // print(DefaultData.defaultData.programs);
      await _db.addPrograms(DefaultData.defaultData.programs);
      await _db.addWeeks(DefaultData.defaultData.weeks);
      await _db.addDays(DefaultData.defaultData.newDays);
      await _db.addExercises(DefaultData.defaultData.exercises);
      await _db.addRounds(DefaultData.defaultData.rounds);
    }
    _programs = await _db.getAllPrograms();
    _weeks = await _db.getAllWeeks();
    _days = await _db.getAllDays();
    _exercises = await _db.getAllExercises();
    _rounds = await _db.getAllRounds();

    await Future.delayed(Duration(milliseconds: 300));
    notifyListeners();
  }

  getTotal() async {
    _programs = await _db.getAllPrograms();
    return _programs.length;
  }

  void addProgram(Program program) {
    if (_programs.length > 0) {
      var lastProgramId = _programs.last.id + 1;
      _programs.add(Program(id: lastProgramId, name: program.name));
      _db.addProgram(Program(id: lastProgramId, name: program.name));
    } else {
      _programs.add(Program(id: 1, name: program.name));
      _db.addProgram(Program(id: 1, name: program.name));
    }
    notifyListeners();
  }

  void addWeek(Week week) {
   
    if (_weeks.length > 0) {

      var lastWeekId = _weeks.last.id + 1;

      _days.toList().forEach((day) {
        var lastDayId = _days.last.id + 1;
        if (day.weekId == _weeks.last.id) {

           _exercises.toList().forEach((exercise) {
            var lastExerciseId = _exercises.last.id + 1;
            if (exercise.dayId == day.id) { 

               _rounds.toList().forEach((round) {
                var lastRoundId = _rounds.last.id + 1;
                if (round.exerciseId == exercise.id) {
                  _rounds.add(Round(id: lastRoundId, weight: round.weight, round: round.round, rep: round.rep, exerciseId: lastExerciseId, dayId: lastDayId, weekId: lastWeekId, programId: round.programId));
                  // _db.addRound(Round(id: lastRoundId, weight: round.weight, round: round.round, rep: round.rep, exerciseId: lastExerciseId, dayId: lastDayId, weekId: lastWeekId, programId: round.programId));
                }
              });

              int calcBestVolume;
              
              if (exercise.currentVolume > exercise.previousVolume) {
                calcBestVolume = exercise.currentVolume;
              } else {
                calcBestVolume = exercise.previousVolume;
              }
              print(calcBestVolume);

              _exercises.add(Exercise(id: lastExerciseId, name: exercise.name, bestVolume: calcBestVolume, previousVolume: exercise.currentVolume, currentVolume: exercise.currentVolume, dayId: lastDayId, weekId: lastWeekId, programId: exercise.programId));
              // _db.addExercise(Exercise(id: lastExerciseId, name: exercise.name, dayId: lastDayId, weekId: lastWeekId, programId: exercise.programId));

            }
            
          });

          _days.add(Day(id: lastDayId, name: day.name, target: day.target, weekId: lastWeekId, programId: day.programId));
          // _db.addDay(Day(id: lastDayId, name: day.name, target: day.target, weekId: lastWeekId, programId: day.programId));
        }
      });

      _weeks.add(Week(id: lastWeekId, seq: week.seq,  name: week.name, programId: week.programId));
      // _db.addWeek(Week(id: lastWeekId, seq: week.seq,  name: week.name, programId: week.programId));
    } else {
      _weeks.add(Week(id: 1, seq: week.seq,  name: week.name, programId: week.programId));
      DefaultData.defaultData.newDays.forEach((day) {
        _days.add(day);
        _db.addDay(day);
      });
      _db.addWeek(Week(id: 1, seq: week.seq,  name: week.name, programId: week.programId));
    } 
    notifyListeners();
  }

  void addDay(Day day) {
    if (_days.length > 0) {
      var lastDayId = _days.last.id + 1;
      _days.add(Day(id: lastDayId, name: day.name, target: day.target, weekId: day.weekId, programId: day.programId));
      _db.addDay(Day(id: lastDayId, name: day.name, target: day.target, weekId: day.weekId, programId: day.programId));
    } else {
      _days.add(Day(id: 1, name: day.name, target: day.target, weekId: day.weekId, programId: day.programId));
      _db.addDay(Day(id: 1, name: day.name, target: day.target, weekId: day.weekId, programId: day.programId));
    }
    notifyListeners();
  }

  void addExercise(Exercise exercise) {
    if (_exercises.length > 0) {
      var lastExerciseId = _exercises.last.id + 1;
      _exercises.add(Exercise(id: lastExerciseId, name: exercise.name, dayId: exercise.dayId, weekId: exercise.weekId, programId: exercise.programId));
      // _db.addExercise(Exercise(id: lastExerciseId, name: exercise.name,  dayId: exercise.dayId, weekId: exercise.weekId, programId: exercise.programId));
    } else {
      _exercises.add(Exercise(id: 1, name: exercise.name, dayId: exercise.dayId, weekId: exercise.weekId, programId: exercise.programId));
      // _db.addExercise(Exercise(id: 1, name: exercise.name, dayId: exercise.dayId, weekId: exercise.weekId, programId: exercise.programId));
    }
    notifyListeners();
  }

  void addRound(Round round) {
   if (_rounds.length > 0) {
      var lastRoundId = _rounds.last.id + 1;
      print(lastRoundId);
      _rounds.add(Round(id: lastRoundId, weight: round.weight, round: round.round, rep: round.rep, exerciseId: round.exerciseId, dayId: round.dayId, weekId: round.weekId, programId: round.programId));
      // _db.addRound(Round(id: lastRoundId, weight: round.weight, round: round.round, rep: round.rep, exerciseId: round.exerciseId, dayId: round.dayId, weekId: round.weekId, programId: round.programId));
    } else {
      _rounds.add(Round(id: 1, weight: round.weight, round: round.round, rep: round.rep, exerciseId: round.exerciseId, dayId: round.dayId, weekId: round.weekId, programId: round.programId));
      // _db.addRound(Round(id: 1, weight: round.weight, round: round.round, rep: round.rep, exerciseId: round.exerciseId, dayId: round.dayId, weekId: round.weekId, programId: round.programId));
    }
    notifyListeners();
  }

  void updateProgram(Program program) {
    var oldTask = _programs.firstWhere((it) => it.id == program.id);
    var replaceIndex = _programs.indexOf(oldTask);
    _programs.replaceRange(replaceIndex, replaceIndex + 1, [program]);
    _db.updateProgram(program);
    notifyListeners();
  }

  void updateWeek(Week week) {
    var oldWeek = _weeks.firstWhere((it) => it.id == week.id);
    var replaceIndex = _weeks.indexOf(oldWeek);
    _weeks.replaceRange(replaceIndex, replaceIndex + 1, [week]);
    _db.updateWeek(week);
    notifyListeners();
  }

  void updateDay(Day day) {
    var oldDay = _days.firstWhere((it) => it.id == day.id);
    var replaceIndex = _days.indexOf(oldDay);
    _days.replaceRange(replaceIndex, replaceIndex + 1, [day]);
    _db.updateDay(day);
    notifyListeners();
  }

  void updateExercise(exercise) {
    var oldExercise = _exercises.firstWhere((it) => it.id == exercise.id);
    var replaceIndex = _exercises.indexOf(oldExercise);
    _exercises.replaceRange(replaceIndex, replaceIndex + 1, [exercise]);
    _db.updateExercise(exercise);
    notifyListeners();
  }

  void updateRound(Round round) {
    // var oldRound = _rounds.firstWhere((round) => round.id == round.id);
    // var replaceIndex = _rounds.indexOf(oldRound);
    // _rounds.replaceRange(replaceIndex, replaceIndex + 1, [round]);
    // _db.updateRound(round);
    // notifyListeners();
  }

  void toggleProgram(Program program) {
    final programIndex = _programs.indexOf(program);
    _programs[programIndex].toggleCompleted();
    _db.updateProgram(program);
    notifyListeners();
  }

  void toggleWeek(Week week) {
    final weekIndex = _weeks.indexOf(week);
    _weeks[weekIndex].toggleCompleted();
    _db.updateWeek(week);
    notifyListeners();
  }

  void toggleDay(Day day) {
    final dayIndex = _days.indexOf(day);
    _days[dayIndex].toggleCompleted();
    _db.updateDay(day);
    notifyListeners();
  }

  void toggleExercise(Exercise exercise) {
    final exerciseIndex = _exercises.indexOf(exercise);
    _exercises[exerciseIndex].toggleCompleted();
    _db.updateExercise(exercise);
    notifyListeners();
  }

  void removeProgram(Program program) {
    _programs.remove(program);
    _weeks.removeWhere((it) => it.programId == program.id);
    _days.removeWhere((it) => it.programId == program.id);
    _exercises.removeWhere((it) => it.programId == program.id);
    _rounds.removeWhere((it) => it.programId == program.id);
    _db.removeProgram(program);
    notifyListeners();
  }

  void removeWeek(Week week) {
    _weeks.remove(week);
    _days.removeWhere((it) => it.weekId == week.id);
    _exercises.removeWhere((it) => it.weekId == week.id);
    _rounds.removeWhere((it) => it.weekId == week.id);
    _db.removeWeek(week);
    notifyListeners();
  }

  void removeDay(Day day) {
    _days.remove(day);
    _exercises.removeWhere((it) => it.dayId == day.id);
    _rounds.removeWhere((it) => it.dayId == day.id);
    _db.removeDay(day);
    notifyListeners();
  }

  void removeExercise(Exercise exercise) {
    _exercises.remove(exercise);
    _rounds.removeWhere((it) => it.exerciseId == exercise.id);
    _db.removeExercise(exercise);
    notifyListeners();
  }

  void removeRound(Round round) {
    _rounds.remove(round);
    _db.removeRound(round);
    notifyListeners();
  }

  getYears() {
    List<SubscriberSeries> data = [];
    List years = [];
    _weeks.sort((a, b) => a.date.compareTo(b.date));
    _weeks.forEach((week) {
      String year = DateFormat('y').format(DateTime.fromMillisecondsSinceEpoch(week.date)).toString();
      if (years.contains(year)) {
      } else {
        var dayExercises = _exercises.where((it) => it.weekId == week.id).toList();
        if (dayExercises.isEmpty) {
        } else {
           years.add(year);
        }
      }
    });

    for (var i = 0; i < years.length && i < 7; i++) {
      var yearWeeks = _weeks.where((it) => DateFormat('y').format(DateTime.fromMillisecondsSinceEpoch(it.date)).toString() == years[i]).toList();
      yearWeeks.forEach((element) {
        var dayExercises = _exercises.where((it) => it.weekId == element.id).toList();
        List volumes = [];
        dayExercises.forEach((day) {
          if(day.currentVolume != 0) {
            volumes.add(day.currentVolume);
          } else {
            volumes.add(0);
          }
        });
        var sum;
        if(volumes.length > 1) {
          sum = volumes.reduce((a, b) => a + b);
        } else if (volumes.length > 0) {
          sum = volumes[0];
        } else if (volumes.length == 0) {
          sum = 0;
        }
        data.add(
          SubscriberSeries(
            year: years[i].substring(0, 4),
            subscribers: sum,
            barColor: charts.ColorUtil.fromDartColor(Colors.blue),
          ),
        );
      
      });
    }
    return data;
  }

  getMonths() {
    List<SubscriberSeries> data = [];
    List months = [];
    _weeks.sort((a, b) => a.date.compareTo(b.date));
    _weeks.forEach((week) {
      String monnth = DateFormat('MMM y').format(DateTime.fromMillisecondsSinceEpoch(week.date)).toString();
      if (months.contains(monnth)) {
      } else {
        var dayExercises = _exercises.where((it) => it.weekId == week.id).toList();
        if (dayExercises.isEmpty) {
        } else {
           months.add(monnth);
        }
       
      }
    });

    for (var i = 0; i < months.length && i < 7; i++) {
      var monthWeeks = _weeks.where((it) => DateFormat('MMM y').format(DateTime.fromMillisecondsSinceEpoch(it.date)).toString() == months[i]).toList();
      monthWeeks.forEach((element) {
        var dayExercises = _exercises.where((it) => it.weekId == element.id).toList();
        List volumes = [];
        dayExercises.forEach((day) {
          if(day.currentVolume != 0) {
            volumes.add(day.currentVolume);
          } else {
            volumes.add(0);
          }
        });
        var sum;
        if(volumes.length > 1) {
          sum = volumes.reduce((a, b) => a + b);
        } else if (volumes.length > 0) {
          sum = volumes[0];
        } else if (volumes.length == 0) {
          sum = 0;
        }
        data.add(
          SubscriberSeries(
            year: months[i].substring(0, 3),
            subscribers: sum,
            barColor:charts.ColorUtil.fromDartColor(Colors.blue),
          ),
        );
      
      });
    }
    return data;
  }

  getWeeks() {
    _weeks.sort((a, b) => a.date.compareTo(b.date));
    List<SubscriberSeries> data = [];
    for (var i = 0; i < allWeeks.length && i < 7; i++) {
      var dayExercises = _exercises.where((it) => it.weekId == allWeeks[i].id).toList();
      List volumes = [];
      dayExercises.forEach((day) {
        if(day.currentVolume != 0) {
          volumes.add(day.currentVolume);
        } else {
          volumes.add(0);
        }
      });
      var sum;
      if(volumes.length > 1) {
        sum = volumes.reduce((a, b) => a + b);
      } else if (volumes.length > 0) {
        sum = volumes[0];
      } else if (volumes.length == 0) {
        sum = 0;
      }
      data.add(
        SubscriberSeries(
          year: 'W' + (i + 1).toString(),
          subscribers: sum,
          barColor:charts.ColorUtil.fromDartColor(Colors.blue),
        ),
      );
    }
    return data;
  }

  getDays() {
    _weeks.sort((a, b) => a.date.compareTo(b.date));
    var allDays = _days.where((i) => i.weekId == _weeks.last.toJson()['id']).toList();
    List<SubscriberSeries> data = [];
    for (int i = 0; i < allDays.length && i < 14; i++) {
      var dayExercises = _exercises.where((it) => it.dayId == allDays[i].id).toList();
      print(dayExercises);
      List volumes = [];
      dayExercises.forEach((day) {
        if(day.currentVolume != 0) {
          volumes.add(day.currentVolume);
        } else {
          volumes.add(0);
        }
      });
      var sum;
      if(volumes.length > 1) {
        sum = volumes.reduce((a, b) => a + b);
      } else if (volumes.length > 0) {
        sum = volumes[0];
      } else if (volumes.length == 0) {
        sum = 0;
      }
      data.add(
        SubscriberSeries(
          year: allDays[i].name.substring(0, 3),
          subscribers: sum,
          barColor:charts.ColorUtil.fromDartColor(Colors.blue),
        ),
      );
    }
    return data;
  }
  
}
