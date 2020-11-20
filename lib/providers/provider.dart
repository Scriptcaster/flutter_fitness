import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_fitness/models/program.dart';
import '../models/week.dart';
import 'database.dart';
import 'package:flutter_fitness/providers/default_data.dart';


// import 'db.dart';

class TodosModel extends ChangeNotifier {
  var _db = DBProvider.db;
  // final List<Program> _programs = [];
  List<Program> _programs = [];
  List<Week> _weeks = [];


  UnmodifiableListView<Program> get allPrograms => UnmodifiableListView(_programs);
  // UnmodifiableListView<Program> get incompletePrograms => UnmodifiableListView(_programs.where((program) => program.completed  == 0));
  // UnmodifiableListView<Program> get completedPrograms => UnmodifiableListView(_programs.where((program) => program.completed  == 1));

  bool get isLoading => _isLoading;

  bool _isLoading = false;

  List<Program> get programs => _programs.toList();
  List<Week> get weeks => _weeks.toList();

  void getPrograms() async {
   var isNew = !await DBProvider.db.dbExists();
    if (isNew) {
      // print(DefaultData.defaultData.programs);
      await _db.addPrograms(DefaultData.defaultData.programs);
      await _db.addWeeks(DefaultData.defaultData.weeks);
      // await _db.addDays(DefaultData.defaultData.days);
      // await _db.addExercises(DefaultData.defaultData.exercises);
      // await _db.addRounds(DefaultData.defaultData.rounds);
    }
    _programs = await _db.getAllPrograms();
    _weeks = await _db.getAllWeeks();
    _weeks.forEach((element) {
      print(element.toJson());
    });
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
  }

  void updateProgram(Program program) {
    var oldTask = _programs.firstWhere((it) => it.id == program.id);
    var replaceIndex = _programs.indexOf(oldTask);
    _programs.replaceRange(replaceIndex, replaceIndex + 1, [program]);
    _db.updateProgram(program);
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
    print(week.toJson());
    _db.updateWeek(week);
    notifyListeners();
  }

  void removeProgram(Program program) {
    _programs.remove(program);
    _db.removeProgram(program);
    notifyListeners();
  }
}
