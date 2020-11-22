import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_fitness/models/program.dart';
import '../models/day.dart';
import '../models/exercise.dart';
import '../models/week.dart';
import 'database.dart';
import 'package:flutter_fitness/providers/default_data.dart';


// import 'db.dart';

class TodosModel extends ChangeNotifier {
  var _db = DBProvider.db;
  // final List<Program> _programs = [];
  List<Program> _programs = [];
  List<Week> _weeks = [];
  List<Day> _days = [];
  List<Exercise> _exercises = [];


  UnmodifiableListView<Program> get allPrograms => UnmodifiableListView(_programs);
  UnmodifiableListView<Week> get allWeeks => UnmodifiableListView(_weeks);
  UnmodifiableListView<Day> get allDays => UnmodifiableListView(_days);
  UnmodifiableListView<Exercise> get allExercises => UnmodifiableListView(_exercises);
  // UnmodifiableListView<Program> get incompletePrograms => UnmodifiableListView(_programs.where((program) => program.completed  == 0));
  // UnmodifiableListView<Program> get completedPrograms => UnmodifiableListView(_programs.where((program) => program.completed  == 1));

  bool get isLoading => _isLoading;

  bool _isLoading = false;

  List<Program> get programs => _programs.toList();
  List<Week> get weeks => _weeks.toList();
  List<Day> get days => _days.toList();
  List<Exercise> get exercises => _exercises.toList();

  void getPrograms() async {
   var isNew = !await DBProvider.db.dbExists();
    if (isNew) {
      // print(DefaultData.defaultData.programs);
      await _db.addPrograms(DefaultData.defaultData.programs);
      await _db.addWeeks(DefaultData.defaultData.weeks);
      await _db.addDays(DefaultData.defaultData.days);
      await _db.addExercises(DefaultData.defaultData.exercises);
      // await _db.addRounds(DefaultData.defaultData.rounds);
    }
    _programs = await _db.getAllPrograms();
    _weeks = await _db.getAllWeeks();
    _days = await _db.getAllDays();
    _exercises = await _db.getAllExercises();
    // _weeks.forEach((element) {
    //   print(element.toJson());
    // });
    // _days = await _db.getAllDaysAll();
    // _exercises = await _db.getAllExercisesAll();
    // _rounds = await _db.getAllRoundsAll();
    // _programs.forEach((it) => _calcTaskCompletionPercent(it.id));
    // _isLoading = false;
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
    _weeks.add(week);
    _db.addWeek(week);
    notifyListeners();
    getPrograms();
  }

  void addDay(Day day) {
    _days.add(day);
    _db.addDay(day);
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
    var oldWeek = _weeks.firstWhere((week) => week.id == week.id);
    var replaceIndex = _weeks.indexOf(oldWeek);
    _weeks.replaceRange(replaceIndex, replaceIndex + 1, [week]);
    _db.updateWeek(week);
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
}
