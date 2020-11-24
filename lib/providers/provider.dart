import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_fitness/models/program.dart';
import 'package:flutter_fitness/models/round.dart';
import '../models/day.dart';
import '../models/exercise.dart';
import '../models/week.dart';
import 'database.dart';
import 'package:flutter_fitness/providers/default_data.dart';

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
      await _db.addDays(DefaultData.defaultData.days);
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
    _programs.add(program);
    _db.addProgram(program);
    notifyListeners();
    getPrograms();
  }

  void addWeek(Week week) {
    if (_weeks.length > 0) {
      var lastWeek = _weeks.firstWhere((it) => it.programId == week.programId);
      _weeks.add(week);
      // _db.addWeek(week);  
    //   // print(lastWeek.toJson());
      _db.addPreviousWeek(week, lastWeek.id);
      getPrograms();
    } else  {
      _weeks.add(week);
      _db.addWeek(week);
    }
    notifyListeners();
    getPrograms();
  }

  void addDay(Day day) {
    _days.add(day);
    _db.addDay(day);
    notifyListeners();
    getPrograms();
  }

  void addExercise(Exercise exercise) {
    _exercises.add(exercise);
    _db.addExercise(exercise);
    notifyListeners();
    getPrograms();
  }

  void addRound(Round round) {
    _rounds.add(round);
    _db.addRound(round);
    notifyListeners();
    getPrograms();
  }

  void updateProgram(Program program) {
    var oldTask = _programs.firstWhere((it) => it.id == program.id);
    var replaceIndex = _programs.indexOf(oldTask);
    _programs.replaceRange(replaceIndex, replaceIndex + 1, [program]);
    _db.updateProgram(program);
    notifyListeners();
  }

  void updateWeek(Week week) {
    var oldWeek = _weeks.firstWhere((week) => week.id == week.id);
    var replaceIndex = _weeks.indexOf(oldWeek);
    _weeks.replaceRange(replaceIndex, replaceIndex + 1, [week]);
    _db.updateWeek(week);
    notifyListeners();
  }

  void updateDay(Day day) {
    var oldDay = _days.firstWhere((day) => day.id == day.id);
    var replaceIndex = _days.indexOf(oldDay);
    _days.replaceRange(replaceIndex, replaceIndex + 1, [day]);
    _db.updateDay(day);
    notifyListeners();
  }

  void updateExercise(exercise) {
    print(exercise.toJson());
    // var oldExercise = _exercises.firstWhere((exercise) => exercise.id == exercise.id);
    // var replaceIndex = _exercises.indexOf(oldExercise);
    // _exercises.replaceRange(replaceIndex, replaceIndex + 1, [exercise]);
    _db.updateExercise(exercise);
    notifyListeners();
  }

  void updateRound(Round round) {
    // var oldRound = _rounds.firstWhere((round) => round.id == round.id);
    // var replaceIndex = _rounds.indexOf(oldRound);
    // _rounds.replaceRange(replaceIndex, replaceIndex + 1, [round]);
    _db.updateRound(round);
    // print(round.toJson());
    notifyListeners();
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
    _db.removeProgram(program);
    notifyListeners();
  }

  void removeWeek(Week week) {
    _weeks.remove(week);
    _db.removeWeek(week);
    notifyListeners();
  }

  void removeDay(Day day) {
    _days.remove(day);
    _db.removeDay(day);
    notifyListeners();
  }

  void removeExercise(Exercise exercise) {
    _exercises.remove(exercise);
    _db.removeExercise(exercise);
    notifyListeners();
  }

  void removeRound(Round round) {
    _rounds.remove(round);
    _db.removeRound(round);
    notifyListeners();
  }
}
