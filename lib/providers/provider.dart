import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_fitness/models/program.dart';
import 'database.dart';
import 'package:flutter_fitness/providers/default_data.dart';


// import 'db.dart';

class TodosModel extends ChangeNotifier {
  var _db = DBProvider.db;
  // final List<Program> _programs = [];
  List<Program> _programs = [];

  UnmodifiableListView<Program> get allPrograms => UnmodifiableListView(_programs);
  // UnmodifiableListView<Program> get incompletePrograms => UnmodifiableListView(_programs.where((program) => program.completed  == 0));
  // UnmodifiableListView<Program> get completedPrograms => UnmodifiableListView(_programs.where((program) => program.completed  == 1));

  bool get isLoading => _isLoading;

  bool _isLoading = false;

  void getPrograms() async {
   var isNew = !await DBProvider.db.dbExists();
    if (isNew) {
      // print(DefaultData.defaultData.programs);
      await _db.addPrograms(DefaultData.defaultData.programs);
      // await _db.addWeeks(DefaultData.defaultData.weeks);
      // await _db.addDays(DefaultData.defaultData.days);
      // await _db.addExercises(DefaultData.defaultData.exercises);
      // await _db.addRounds(DefaultData.defaultData.rounds);
    }
    _programs = await _db.getAllPrograms();
    _programs.forEach((element) {
      print(element.toJson());
    });
    // _weeks = await _db.getAllWeeks();
    // _days = await _db.getAllDaysAll();
    // _exercises = await _db.getAllExercisesAll();
    // _rounds = await _db.getAllRoundsAll();
    // _programs.forEach((it) => _calcTaskCompletionPercent(it.id));
    // _isLoading = false;
    await Future.delayed(Duration(milliseconds: 300));
    notifyListeners();
  }

  void addProgram(Program program) {
    _programs.add(program);
    _db.addProgram(program);
    notifyListeners();
  }

  void toggleProgram(Program program) {
    final programIndex = _programs.indexOf(program);
    _programs[programIndex].toggleCompleted();
    _db.updateProgram(program);
    notifyListeners();
  }

  void removeProgram(Program program) {
    _programs.remove(program);
    _db.removeProgram(program);
    notifyListeners();
  }
}
