// import 'package:bench_more/home/subscriber_series.dart';
import 'package:flutter_fitness/models/round.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:io';


import '../models/day.dart';
import '../models/exercise.dart';
import '../models/program.dart';
import '../models/week.dart';
import 'default_data.dart';

// import 'default_data.dart';

// import 'package:charts_flutter/flutter.dart' as charts;

class DBProvider {
  static Database _database;

  DBProvider._();
  static final DBProvider db = DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  get _dbPath async {
    String documentsDirectory = await _localPath;
    return p.join(documentsDirectory, "db_benchy124.db");
  }

  Future<bool> dbExists() async {
    return File(await _dbPath).exists();
  }

  initDB() async {
    String path = await _dbPath;
    return await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute("""CREATE TABLE Program (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        completed INTEGER NOT NULL DEFAULT 0,
        date INTEGER
      )""");
      await db.execute("""CREATE TABLE Week (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        completed INTEGER NOT NULL DEFAULT 0,
        date INTEGER,
        programId INTEGER
      )""");
      await db.execute("""CREATE TABLE Day (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        target TEXT,
        completed INTEGER NOT NULL DEFAULT 0,
        weekId INTEGER,
        programId INTEGER
      )""");
      await db.execute("""CREATE TABLE Exercise (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        completed INTEGER NOT NULL DEFAULT 0,
        bestVolume INTEGER,
        previousVolume INTEGER,
        currentVolume INTEGER,
        dayId INTEGER,
        weekId INTEGER,
        programId INTEGER
      )""");
      await db.execute("""CREATE TABLE Round (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        weight INTEGER,
        round INTEGER,
        rep INTEGER,
        exerciseId INTEGER,
        dayId INTEGER,
        weekId INTEGER,
        programId INTEGER
      )""");
    });
  }

  addPrograms(List<Program> programs) async {
    final db = await database;
    programs.forEach((program) async { await db.insert("Program", program.toJson()); });
  }

  addWeeks(List<Week> weeks) async {
    final db = await database;
    weeks.forEach((week) async { await db.insert("Week", week.toJson()); });
  }

  addDays(List<Day> days) async {
    final _db = await database;
    days.forEach((day) async { await _db.insert("Day", day.toJson()); });
  }

  addExercises(List<Exercise> exercises) async {
    final _db = await database;
    exercises.forEach((exercise) async { await _db.insert("Exercise", exercise.toJson()); });
  }

  addRounds(List<Round> rounds) async {
    final _db = await database;
    rounds.forEach((round) async { await _db.insert("Round", round.toJson()); });
  }

  Future<int> addProgram(Program program) async {
    final _db = await database;
    return _db.insert('Program', program.toJson());
  }

  // Future<int> addWeek(Week week) async {
  //   final _db = await database;
  //   var _weekTable = await _db.rawQuery("SELECT MAX(id)+1 as id FROM Week");
  //   int _weekId = _weekTable.first["id"];
  //   DefaultData.defaultData.days.forEach((day) async {
  //     print('add day');
  //     await _db.insert("Day", Day(name: day.name, target: day.target, weekId: _weekId, programId: week.programId).toJson());
  //   });
  //   return _db.insert('Week', week.toJson());
  // }

  Future<int> addWeek(Week week) async {
    final _db = await database;
    var _weekTable = await _db.rawQuery("SELECT MAX(id)+1 as id FROM Week");
    int _weekId = _weekTable.first["id"];
    DefaultData.defaultData.days.forEach((day) async {
      print('add day');
      await _db.insert("Day", Day(name: day.name, target: day.target, weekId: _weekId, programId: week.programId).toJson());
    });
    return _db.insert('Week', week.toJson());
  }


  Future<int> addPreviousWeek(Week week, previousWeekId, ) async {
    final _db = await database;
    await _db.insert('Week', week.toJson());
    // var _newDayId = await _db.rawQuery("SELECT MAX(id)+1 as id FROM Day");
    // var _newExerciseId = await _db.rawQuery("SELECT MAX(id)+1 as id FROM Exercise");

    var _oldDays = await _db.query("Day", where: "weekId = ?", whereArgs: [previousWeekId]);
    var _oldExercises = await _db.query("Exercise", where: "weekId = ?", whereArgs: [previousWeekId]);
    var _oldRounds = await _db.query("Round", where: "weekId = ?", whereArgs: [previousWeekId]);

    // print(previousWeekId);
    // // // int incrementDay = _newDayId.first['id'];
    // // // int incrementExercise = _newExerciseId.first['id'];
    print(previousWeekId);
    if (_oldDays.asMap().isNotEmpty) {
      _oldDays.forEach((element) async {
        print(element);
        await _db.insert("Day", Day( name: element['name'], target: element['target'], weekId: previousWeekId + 1, programId: element['programId']).toJson());
        // if (_oldExercises.isNotEmpty) {
        //   _oldExercises.asMap().forEach((index2, element2) {
        //     if (element['id'] == element2['dayId']) {
        //       // _db.insert("Exercise", {
        //       //   'name': element2['name'],
        //       //   'bestVolume': element2['bestVolume'],
        //       //   'previousVolume': element2['previousVolume'],
        //       //   'currentVolume': element2['currentVolume'],
        //       //   'dayId': incrementDay,
        //       //   'weekId': week.id,
        //       //   'programId': element['programId']
        //       // });
        //       if (_oldRounds.isNotEmpty) {
        //         _oldRounds.asMap().forEach((index3, element3) {
        //           if (element2['id'] == element3['exerciseId']) {
        //             // _db.insert("Round", {
        //             //   'weight': element3['weight'],
        //             //   'round': element3['round'],
        //             //   'rep': element3['rep'],
        //             //   'dayId': incrementDay,
        //             //   'exerciseId': incrementExercise,
        //             //   'weekId': week.id,
        //             //   'programId': element['programId']
        //             // });
        //           }
        //         });
        //       }
        //       // incrementExercise++;
        //     }
        //   });
        // }
        // // incrementDay++;
      });
    }
    
    // return _db.insert('Week', Week(id: previousWeekId + 1 , name: week.name, programId: week.programId).toJson());
  }
  

  Future<int> addDay(Day day) async {
    final _db = await database;
    return _db.insert('Day', day.toJson());
  }

  Future<int> addExercise(Exercise exercise) async {
    final _db = await database;
    return _db.insert('Exercise', exercise.toJson());
  }

  Future<int> addRound(Round round) async {
    final _db = await database;
    return _db.insert('Round', round.toJson());
  }

  // Future<int> addExercise(Exercise exercise) async {
  //   final _db = await database;
  //   var _table = await _db.rawQuery("SELECT MAX(id)+1 as id FROM Exercise");
  //   int _id = _table.first["id"];
  //   if (_id == null) {_id = 0;}
  //   return await _db.rawInsert("INSERT Into Exercise (id, name, bestVolume, previousVolume, currentVolume, dayId, weekId, programId)"" VALUES (?,?,?,?,?,?,?,?)", [_id, exercise.name, exercise.bestVolume, exercise.previousVolume, exercise.currentVolume, exercise.dayId, exercise.weekId, exercise.programId]);
  // }

  // Future<int> addRound(Round round) async {
  //   final _db = await database;
  //   // print(round.weight);
  //   // _db.transaction<void>((txn) async {
  //   //   await txn.delete('Round', where: 'exerciseId = ?', whereArgs: [exerciseId]);
  //   // });
  //   // round.forEach((element) async {
  //   //   print(element);
  //   //   return await _db.rawInsert("INSERT Into Round (id, weight, round, rep, exerciseId, dayId, weekId, programId)"" VALUES (?,?,?,?,?,?,?,?)", [element.id, element.weight, element.round, element.rep, element.exerciseId, element.dayId, element.weekId, element.programId]);
  //   // });
  //   var _lastRow = await _db.query("Round", where: "exerciseId = ?", whereArgs: [round.exerciseId]);
  //   var _table = await _db.rawQuery("SELECT MAX(id)+1 as id FROM Round");
  //   if (_lastRow.isNotEmpty) {
  //     return await _db.rawInsert("INSERT Into Round (id, weight, round, rep, exerciseId,  dayId, weekId, programId)"" VALUES (?,?,?,?,?,?,?,?)", [
  //       _table.first["id"],
  //       _lastRow.last['weight'],
  //       _lastRow.last['round'],
  //       _lastRow.last['rep'],
  //       round.exerciseId,
  //       round.dayId,
  //       round.weekId,
  //       round.programId
  //     ]);
  //   } else {
  //     return await _db.rawInsert("INSERT Into Round (id, weight, round, rep, exerciseId, dayId, weekId, programId)"" VALUES (?,?,?,?,?,?,?,?)", [
  //       round.id,
  //       round.weight,
  //       round.round,
  //       round.rep,
  //       round.exerciseId,
  //       round.dayId,
  //       round.weekId,
  //       round.programId
  //     ]);
  //   }
  // }

  Future<List<Program>> getAllPrograms() async {
    final _db = await database;
    // var result = await _db.query('Program');
    var result =  await _db.query('Program ORDER BY date DESC');
    // print(result);
    return result.map((it) => Program.fromJson(it)).toList();
  }

  Future<List<Week>> getAllWeeks() async {
    final _db = await database;
    var result = await _db.query('Week ORDER BY id DESC');
    // print(result);
    // print(result);
    // print('get Weeks');
    return result.map((it) => Week.fromJson(it)).toList();
  }

  Future<List<Day>> getAllDays() async {
    final _db = await database;
    var result = await _db.query('Day');
    return result.map((it) => Day.fromJson(it)).toList();
  }

  Future<List<Exercise>> getAllExercises() async {
    final _db = await database;
    var result = await _db.query('Exercise');
    return result.map((it) => Exercise.fromJson(it)).toList();
  }

  Future<List<Round>> getAllRounds() async {
    final _db = await database;
    var result = await _db.query('Round');
    return result.map((it) => Round.fromJson(it)).toList();
  }
















  // Future<List<SubscriberSeries>> getChartData() async {
  //   final db = await database;
  //   var currentWeek = await db.query('Week ORDER BY date DESC LIMIT 1');
  //   List fullListDaysIds = [];
  //   for (int i = 0; i < currentWeek.length; i++) {
  //     var _allDays = await db.query("Day", where: "weekId = ?", whereArgs: [currentWeek[i]['id']]);
  //     for (int k = 0; k < _allDays.length; k++) {
  //       fullListDaysIds.add(_allDays[k]);
  //     }
  //   }
  //   List<SubscriberSeries> data = [];
  //   List dayExercises = [];
  //   for (int i = 0; i < 7; i++) {
  //     var dayExercises = await db.query("Exercise", where: "dayId = ?", whereArgs: [fullListDaysIds[i]['id']]);
  //     List volumes = [];
  //     dayExercises.toList().forEach((day) {
  //       volumes.add(day['currentVolume']);
  //     });
  //     var sum;
  //     if(volumes.length > 1) {
  //       sum = volumes.reduce((a, b) => a + b);
  //     } else if (volumes.length > 0) {
  //       sum = volumes[0];
  //     } else if (volumes.length == 0) {
  //       sum = 0;
  //     }
  //       data.add(
  //         SubscriberSeries(
  //           year: fullListDaysIds[i]['dayName'].substring(0, 3),
  //           subscribers: sum,
  //           barColor:charts.ColorUtil.fromDartColor(Colors.blue),
  //         ),
  //       );
  //   }
  //   // return resultWeeks.map((it) => Week.fromJson(it)).toList();
  //   return data;
  // }





  











  // Future<List<Day>> getAllDays(String weekId) async {
  //   final db = await database;
  //   var res = await db.query("Day", where: 'weekId = ?', whereArgs: [weekId]);
  //   List<Day> list = res.isNotEmpty ? res.map((c) => Day.fromMap(c)).toList() : [];
  //   return list;
  // }

  // Future<List<Exercise>> getAllExercises(int dayId) async {
  //   final db = await database;
  //   var dayExercises = await db.query("Exercise", where: "dayId = ?", whereArgs: [dayId]);
  //   // print(dayExercises);
  //   var previousDays = await db.rawQuery( "SELECT * FROM Exercise WHERE dayId != ? ORDER BY id DESC", [dayId]);
  //   // previousDays.toList().forEach((element) {
  //   dayExercises.toList().forEach((element2) {
  //     previousDays.toList().forEach((element) {
  //       if (element['name'] == element2['name']) {
  //         // print(element['currentVolume']);
  //       }
  //     });
  //   });
  //   // });
  //   List<Exercise> fullList = List<Exercise>();
  //   for (int i = 0; i < dayExercises.length; i++) {
  //     fullList.add(Exercise.fromMap(dayExercises[i]));
  //     var _rounds = await db.query("Round", where: "exerciseId = ?", whereArgs: [dayExercises[i]['id']]);
  //     List<Round> _finalRounds = _rounds.isNotEmpty ? _rounds.map((c) => Round.fromMap(c)).toList() : [];
  //     var previousExerciseVolume = await db.rawQuery( "SELECT * FROM Exercise WHERE id < ? AND name = ? ORDER BY id DESC", [dayExercises[i]['id'], dayExercises[i]['name']]);
  //     if (previousExerciseVolume.length > 0) {
  //       for (int e = 0; e < 1; e++) {
  //         fullList[i].previousVolume = previousExerciseVolume[e]['currentVolume'];
  //       }
  //     }
  //     fullList[i].round = _finalRounds;
  //   }
  //   return fullList;
  // }

  // Future<List<Exercise>> getAllExercisesAll() async {
  //   final db = await database;
  //   var dayExercises = await db.query('Exercise');
  //   List<Exercise> fullList = List<Exercise>();
  //   for (int i = 0; i < dayExercises.length; i++) {
  //     fullList.add(Exercise.fromJson(dayExercises[i]));
  //     var _rounds = await db.query("Round", where: "exerciseId = ?", whereArgs: [dayExercises[i]['id']]);
  //     List<Round> _finalRounds = _rounds.isNotEmpty ? _rounds.map((c) => Round.fromMap(c)).toList() : [];
  //     var previousExerciseVolume = await db.rawQuery( "SELECT * FROM Exercise WHERE id < ? AND name = ? ORDER BY id DESC", [dayExercises[i]['id'], dayExercises[i]['name']]);
  //     if (previousExerciseVolume.length > 0) {
  //       for (int e = 0; e < 1; e++) {
  //         fullList[i].previousVolume = previousExerciseVolume[e]['currentVolume'];
  //       }
  //     }
  //     print('get exercise');
  //     fullList[i].round = _finalRounds;
  //   }
  //   // print(fullList);
  //   // return dayExercises.map((it) => Exercise.fromJson(it)).toList();
    
  //   return fullList;
  // }

  // Future<List<Round>> getAllRounds(int exerciseId) async {
  //   final _db = await database;
  //   var _res = await _db.query("Round", where: "exerciseId = ?", whereArgs: [exerciseId]);
  //   List<Round> _list = _res.isNotEmpty ? _res.map((c) => Round.fromMap(c)).toList() : [];
  //   return _list;
  // }

  // Future<List<Round>> getAllRoundsAll() async {
  //   final _db = await database;
  //   var _res = await _db.query("Round");
  //   // var _res = await _db.query("Round",
  //   //     where: "date BETWEEN '2020-11-09' AND '2014-10-11'");
  //   // var _res = await _db.rawQuery(
  //   //     "SELECT * FROM Week WHERE date BETWEEN '2020-11-06' AND '2014-11-06'");
  //   List<Round> _list = _res.isNotEmpty ? _res.map((c) => Round.fromMap(c)).toList() : [];
  //   _list.forEach((element) { 
  //     print(element.toJson());
  //   });
  //   return _list;
  // }

  // getPreviousVolume(int id, String name) async {
  //   final db = await database;
  //   var previousExerciseVolume = await db.rawQuery("SELECT * FROM Exercise WHERE id < ? AND name = ? ORDER BY id DESC LIMIT 1", [id, name]);
  //   if (previousExerciseVolume.isNotEmpty) { return previousExerciseVolume.first['currentVolume']; }
  // }

  // getBestVolume(int id, String name) async {
  //   final db = await database;
  //   var bestExerciseVolume = await db.rawQuery("SELECT MAX(currentVolume) as currentVolume FROM Exercise WHERE id != ? AND name = ?", [id, name]);
  //   if (bestExerciseVolume.isNotEmpty) { return bestExerciseVolume.first['currentVolume']; }
  // }

  // Future<int> addPreviousWeek(previousWeekId, previousSeq, Week week) async {
  //   final _db = await database;
  //   var _newDayId = await _db.rawQuery("SELECT MAX(id)+1 as id FROM Day");
  //   var _newExerciseId = await _db.rawQuery("SELECT MAX(id)+1 as id FROM Exercise");

  //   var _oldDays = await _db.query("Day", where: "weekId = ?", whereArgs: [previousWeekId]);
  //   var _oldExercises = await _db.query("Exercise", where: "weekId = ?", whereArgs: [previousWeekId]);
  //   var _oldRounds = await _db.query("Round", where: "weekId = ?", whereArgs: [previousWeekId]);

  //   int incrementDay = _newDayId.first['id'];
  //   int incrementExercise = _newExerciseId.first['id'];

  //   if (_oldDays.isNotEmpty) {
  //     _oldDays.asMap().forEach((index, element) async {
  //       await _db.insert("Day", Day( dayName: element['dayName'], target: element['target'], weekId: week.id, programId: element['programId']).toMap());
  //       if (_oldExercises.isNotEmpty) {
  //         _oldExercises.asMap().forEach((index2, element2) {
  //           if (element['id'] == element2['dayId']) {
  //             _db.insert("Exercise", {
  //               'name': element2['name'],
  //               'bestVolume': element2['bestVolume'],
  //               'previousVolume': element2['previousVolume'],
  //               'currentVolume': element2['currentVolume'],
  //               'dayId': incrementDay,
  //               'weekId': week.id,
  //               'programId': element['programId']
  //             });
  //             if (_oldRounds.isNotEmpty) {
  //               _oldRounds.asMap().forEach((index3, element3) {
  //                 if (element2['id'] == element3['exerciseId']) {
  //                   _db.insert("Round", {
  //                     'weight': element3['weight'],
  //                     'round': element3['round'],
  //                     'rep': element3['rep'],
  //                     'dayId': incrementDay,
  //                     'exerciseId': incrementExercise,
  //                     'weekId': week.id,
  //                     'programId': element['programId']
  //                   });
  //                 }
  //               });
  //             }
  //             incrementExercise++;
  //           }
  //         });
  //       }
  //       incrementDay++;
  //     });
  //   }
  //   return await _db.rawInsert("INSERT Into Week (id, program, seq, name, completed, date)"" VALUES (?,?,?,?,?,?)",[ week.id, week.program, previousSeq, week.name, week.isCompleted, week.date ]);
  // }

  Future<int> updateProgram(Program program) async {
    final db = await database;
    return db.update('Program', program.toJson(), where: 'id = ?', whereArgs: [program.id]);
  }

  Future<int> updateWeek(Week week) async {
    final db = await database;
    return db.update('Week', week.toJson(), where: 'id = ?', whereArgs: [week.id]);
  }

  Future<int> updateDay(Day day) async {
    final _db = await database;
    return _db.update('Day', day.toJson(), where: 'id = ?', whereArgs: [day.id]);
  }

  Future<int> updateExercise(Exercise exercise) async {
    final _db = await database;
    return _db.update('Exercise', exercise.toJson(), where: 'id = ?', whereArgs: [exercise.id]);
  }

  Future<int> updateRound(Round round) async {
    final _db = await database;
    return _db.update('Round', round.toJson(), where: 'id = ?', whereArgs: [round.id]);
  }

  // Future<int> updateDayTarget(Day day) async {
  //   final _db = await database;
  //   return await _db.rawUpdate('''UPDATE Day SET target = ? WHERE id = ?''', [day.target, day.id]);
  // }

  // Future<int> updateDay(Day day) async {
  //   final db = await database;
  //   return db.update('Day', day.toMap(), where: 'id = ?', whereArgs: [day.id]);
  // }


 

  // // addRounds(List<Round> rounds) async {
  // //   final db = await database;
  // //   rounds.forEach((round) async { var res = await db.insert("Round", round.toMap()); });
  // // }

  // // await db.insert("Day", Day(dayName: day.dayName, target: day.target, weekId: week.id, programId: week.program).toMap());

  // saveExercise(Exercise exercise) async {
  //   final _db = await database;
  //   var _table = await _db.rawQuery("SELECT MAX(id)+1 as id FROM Round");
  //   int _id = _table.first['id'];
  //   int incement = _id;
  //   exercise.round.forEach((element) async {
  //     // print(newExercise.id);
  //     // print(element.toJson());
  //     // print(_id);
      
  //     if (element.id == null) {
  //       print(exercise.id);
  //       // incement = _id++;
  //       // print(incement);
  //       await _db.insert("Round", Round(weight: element.weight, round: element.round, rep: element.rep, exerciseId: exercise.id, dayId: exercise.dayId, weekId: exercise.weekId, programId: exercise.programId).toMap());
  //       // await _db.rawInsert("INSERT Into Round (id, weight, round, rep, exerciseId, dayId, weekId, programId)"" VALUES (?,?,?,?,?,?,?,?)", [incement, element.weight, element.round, element.rep, newExercise.id, newExercise.dayId, newExercise.weekId, newExercise.programId]);
  //     } else {
  //       await _db.rawUpdate('''UPDATE Round SET weight = ?, round = ?, rep = ? WHERE id = ?''', [element.weight, element.round, element.rep, element.id]);
  //     }
  //   });

  //   // newExercise.round.forEach((round) async { var res = await _db.insert("Round", round.toMap()); });
   
  
  //   // var _table = await _db.rawQuery("SELECT MAX(id)+1 as id FROM Round");
  //   // int _id = _table.first['id'];

  //   // _db.transaction<void>((txn) async {
  //   //   await txn.delete('Round', where: 'exerciseId = ?', whereArgs: [newExercise.id]);
  //   // });
    
  //   //   if (_id == null) {
  //   //     //  print(_id);
  //   //     for (var i = 0; i < newExercise.round.length; i++) {
  //   //       // print('insert 1');
  //   //       await _db.rawInsert("INSERT Into Round (id, weight, round, rep, exerciseId, dayId, weekId, programId)"" VALUES (?,?,?,?,?,?,?,?)", [i, newExercise.round[i].weight, newExercise.round[i].round, newExercise.round[i].rep, newExercise.round[i].exerciseId, newExercise.round[i].dayId, newExercise.round[i].weekId, newExercise.round[i].programId]);
  //   //     }
  //   //   } else {
  //   //     // print(_id);
  //   //     for (var i = 0; i < newExercise.round.length; i++) {
  //   //       print(_id + i);
  //   //       await _db.rawInsert("INSERT Into Round (id, weight, round, rep, exerciseId, dayId, weekId, programId)"" VALUES (?,?,?,?,?,?,?,?)", [_id + i, newExercise.round[i].weight, newExercise.round[i].round, newExercise.round[i].rep, newExercise.round[i].exerciseId, newExercise.round[i].dayId, newExercise.round[i].weekId, newExercise.round[i].programId]);
  //   //     }
  //   //   }
  //   // }
  //   // newExercise.round.forEach((element) async {
       
  //     // print(element.weight);
  //     // if (_id == null) {
  //     //   _id = 1;
  //     // //   print(element.id);
  //       // return await _db.rawInsert("INSERT Into Round (id, weight, round, rep, exerciseId, dayId, weekId, programId)"" VALUES (?,?,?,?,?,?,?,?)", [_id, element.weight, element.round, element.rep, element.exerciseId, element.dayId, element.weekId, element.programId]);
  //     // } else {
  //       // return await _db.rawInsert("INSERT Into Round (id, weight, round, rep, exerciseId, dayId, weekId, programId)"" VALUES (?,?,?,?,?,?,?,?)", [_id, element.weight, element.round, element.rep, element.exerciseId, element.dayId, element.weekId, element.programId]);

  //     //   print(element.id);
  //       // await _db.rawUpdate('''UPDATE Round SET weight = ?, round = ?, rep = ? WHERE id = ?''', [element.weight, element.round, element.rep, element.id]);
  //     // }
  //   // });
  //   // }

  //   // var _lastRow = await _db.query("Round", where: "exerciseId = ?", whereArgs: [round.exerciseId]);
  //   // var _table = await _db.rawQuery("SELECT MAX(id)+1 as id FROM Round");
  //   // if (_lastRow.isNotEmpty) {
  //   //   return await _db.rawInsert("INSERT Into Round (id, weight, round, rep, exerciseId,  dayId, weekId, programId)"" VALUES (?,?,?,?,?,?,?,?)", [
  //   //     _table.first["id"],
  //   //     _lastRow.last['weight'],
  //   //     _lastRow.last['round'],
  //   //     _lastRow.last['rep'],
  //   //     round.exerciseId,
  //   //     round.dayId,
  //   //     round.weekId,
  //   //     round.programId
  //   //   ]);
  //   // } else {
  //   //   return await _db.rawInsert("INSERT Into Round (id, weight, round, rep, exerciseId, dayId, weekId, programId)"" VALUES (?,?,?,?,?,?,?,?)", [
  //   //     round.id,
  //   //     round.weight,
  //   //     round.round,
  //   //     round.rep,
  //   //     round.exerciseId,
  //   //     round.dayId,
  //   //     round.weekId,
  //   //     round.programId
  //   //   ]);
  //   // }

  // }

  // Future<int> updateRound(Round newRound) async {
  //   final _db = await database;
  //   return await _db.rawUpdate('''UPDATE Round SET weight = ?, round = ?, rep = ? WHERE id = ?''', [newRound.weight, newRound.round, newRound.rep, newRound.id]);
  // }

  // // updateExerciseName(Exercise exerercise) async {
  // //   final db = await database;
  // //   return await db.rawUpdate('''UPDATE Exercise SET name = ? WHERE id = ?''',
  // //       [exerercise.name, exerercise.id]);
  // // }

  // updateExerciseBestVolume(bestVolume, id) async {
  //   final db = await database;
  //   return await db.rawUpdate('''UPDATE Exercise SET bestVolume = ? WHERE id = ?''', [bestVolume, id]);
  // }

  // updateExercisePreviousVolume(previousVolume, id) async {
  //   final db = await database;
  //   return await db.rawUpdate('''UPDATE Exercise SET previousVolume = ? WHERE id = ?''', [previousVolume, id]);
  // }

  Future<void> removeProgram(Program program) async {
    final _db = await database;
    return _db.transaction<void>((txn) async {
      await txn.delete('Round', where: 'programId = ?', whereArgs: [program.id]);
      await txn.delete('Exercise', where: 'programId = ?', whereArgs: [program.id]);
      await txn.delete('Day', where: 'programId = ?', whereArgs: [program.id]);
      await txn.delete('Week', where: 'programId = ?', whereArgs: [program.id]);
      await txn.delete('Program', where: 'id = ?', whereArgs: [program.id]);
    });
  }

  Future<void> removeWeek(Week week) async {
    final _db = await database;
    return _db.transaction<void>((txn) async {
      await txn.delete('Round', where: 'weekId = ?', whereArgs: [week.id]);
      await txn.delete('Exercise', where: 'weekId = ?', whereArgs: [week.id]);
      await txn.delete('Day', where: 'weekId = ?', whereArgs: [week.id]);
      await txn.delete('Week', where: 'id = ?', whereArgs: [week.id]);
    });
  }

  Future<void> removeDay(Day day) async {
    final db = await database;
    return db.transaction<void>((txn) async {
      await txn.delete('Round', where: 'dayId = ?', whereArgs: [day.id]);
      await txn.delete('Exercise', where: 'dayId = ?', whereArgs: [day.id]);
      await txn.delete('Day', where: 'id = ?', whereArgs: [day.id]);
    });
  }

  Future<void> removeExercise(Exercise exercise) async {
    final db = await database;
    return db.transaction<void>((txn) async {
      await txn.delete('Round', where: 'exerciseId = ?', whereArgs: [exercise.id]);
      await txn.delete('Exercise', where: 'id = ?', whereArgs: [exercise.id]);
    });
  }

  Future<void> removeRound(Round round) async {
    final _db = await database;
    var _table = await _db.query("Round", where: "exerciseId = ?", whereArgs: [round.exerciseId]);
    return _db.delete("Round", where: "id = ?", whereArgs: [_table.last["id"]]);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  closeDB() {
    if (_database != null) {
      _database.close();
    }
  }
}
