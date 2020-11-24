import 'package:flutter/material.dart';
import 'package:flutter_fitness/models/exercise.dart';
import 'package:flutter_fitness/models/round.dart';
import 'package:flutter_fitness/providers/provider.dart';
import 'package:provider/provider.dart';

class ExerciseScreen extends StatefulWidget {
  ExerciseScreen({this.id, this.name, this.bestVolume, this.previousVolume, this.currentVolume, this.dayId, this.weekId, this.programId});
  final int id;
  final String name;
  final int bestVolume;
  final int previousVolume;
  final int currentVolume;
  final int dayId;
  final int weekId; 
  final int programId; 
  
  @override
  _StartExerciseScreenState createState() => _StartExerciseScreenState();
}
class _StartExerciseScreenState extends State<ExerciseScreen> { _StartExerciseScreenState();
  TextEditingController _exerciseController = TextEditingController();
  int previousExerciseVolume  = 0;
  int bestExerciseVolume = 0;
  int myCurrentVolume;
  String exerciseName;

  @override
  void initState() {
    super.initState();
    _exerciseController.text = widget.name;
    myCurrentVolume = widget.currentVolume;
    // setState(() {
      exerciseName = widget.name;
    // });
  }

  List<Color> colors = [Colors.blue, Colors.white, Colors.white];
  List<bool> _selected = [true, false, false];



  _updateCurrentVolume(_round, subtract) async {
    setState(() {
      if (subtract) {
        if (_selected[0]) {
        _round.weight -= 5;
        } else if (_selected[1]) {
          _round.round -= 1;
        } else if(_selected[2]) {
          _round.rep -= 1;
        }
      } else {
         if (_selected[0]) {
        _round.weight += 5;
        } else if (_selected[1]) {
          _round.round += 1;
        } else if(_selected[2]) {
          _round.rep += 1;
        }
      }
      // print(_round.toJson());
      // widget.exercise.currentVolume = 0;
      // widget.exercise.round.forEach((i) {
      // widget.exercise.currentVolume += i.weight*i.round*i.rep;
      // });
    });
    // await DBProvider.db.updateRound(Round(id: _round.id, weight: _round.weight, round: _round.round, rep: _round.rep, exerciseId: widget.exercise.dayId ));
    // await DBProvider.db.updateExercise(Exercise( id: widget.exercise.id, name: widget.exercise.name, bestVolume: widget.exercise.bestVolume, previousVolume: widget.exercise.previousVolume, currentVolume: widget.exercise.currentVolume, dayId: widget.id ));
    // widget.parentUpdater();
  }



  // refreshVolumes(id, value) async {
  //   var getPreviousExerciseVolume = await DBProvider.db.getPreviousVolume(id, value);
  //   if (getPreviousExerciseVolume != null) {
  //     previousExerciseVolume = getPreviousExerciseVolume;
  //     await DBProvider.db.updateExercisePreviousVolume(previousExerciseVolume, id);
  //   }
  //   var getBestExerciseVolume = await DBProvider.db.getBestVolume(id, value);
  //   if (getBestExerciseVolume != null) {
  //     bestExerciseVolume = getBestExerciseVolume;
  //     await DBProvider.db.updateExerciseBestVolume(bestExerciseVolume, id);
  //   }    
  // }
  
  _updateCurrentVolumeOnRemove(exercise) async {
    exercise.currentVolume = 0;
    for (int i = 0; i < exercise.round.length - 1; i++) {   
      exercise.currentVolume += exercise.round[i].weight*exercise.round[i].round*exercise.round[i].rep;
    }
    // await DBProvider.db.updateExercise(Exercise( id: exercise.id, name: exercise.name, bestVolume: exercise.bestVolume, previousVolume: exercise.previousVolume, currentVolume: exercise.currentVolume, dayId: widget.id, weekId: widget.weekId, programId: widget.programId )); 
    // model.updateChart(Exercise(id: exercise.id, name: exercise.name, bestVolume: exercise.bestVolume, previousVolume: exercise.previousVolume, currentVolume: exercise.currentVolume, dayId: widget.id, weekId: widget.weekId, programId: widget.programId));
    setState(() {});                     
  }

  _updateCurrentVolumeOnAdd(exercise) async {
    // exercise.round.add(exercise.round.last);
    // exercise.currentVolume = 0;
    // for (int i = 0; i < exercise.round.length; i++) {   
    //   exercise.currentVolume += exercise.round[i].weight*exercise.round[i].round*exercise.round[i].rep;
    // }
    // // await DBProvider.db.updateExercise(Exercise( id: exercise.id, name: exercise.name, bestVolume: exercise.bestVolume, previousVolume: exercise.previousVolume, currentVolume: exercise.currentVolume, dayId: widget.id, weekId: widget.weekId, programId: widget.programId )); 
    // // await DBProvider.db.addRound( Round( weight: 0, round: 0, rep: 0, exerciseId: exercise.id, dayId: widget.id, weekId: widget.weekId, programId: widget.programId )); 

    // setState(() {});                    
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodosModel>(builder: (context, programs, child) {
      Exercise _exercise;
      try {
        _exercise = programs.exercises.firstWhere((exercise) => exercise.id == widget.id, orElse: () => null);
        // print(_exercise.toJson());
      } catch (e) {
        return Container(
          color: Colors.white,
        );
      }
      var _rounds = programs.allRounds.where((round) => round.exerciseId == widget.id).toList();
      var _color = Colors.pink;
      return Theme(
        data: ThemeData(primarySwatch: _color),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            title: Text(exerciseName),
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: _color),
            actions: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  showDialog( context: context, builder: (BuildContext context) {
                    _exerciseController.text = widget.name;
                    return AlertDialog(
                      title: Text("Edit Week"),
                      content: TextField(
                        style: new TextStyle(fontSize: 20.0),
                        keyboardType: TextInputType.text,
                        controller: _exerciseController,
                        onSubmitted: (value) => _exerciseController.text = value,
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Close"),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        FlatButton(
                          child: Text("Save"),
                          onPressed: () {
                            if (_exerciseController.text.isEmpty) {
                            } else {
                              Provider.of<TodosModel>(context, listen: false).updateExercise(Exercise(
                                id: widget.id, 
                                name: _exerciseController.text, 
                                completed: _exercise.completed, 
                                bestVolume: _exercise.bestVolume, 
                                previousVolume: _exercise.previousVolume,
                                currentVolume: myCurrentVolume,
                                dayId: _exercise.dayId, 
                                weekId: _exercise.weekId, 
                                programId: _exercise.programId
                              ));
                              Navigator.pop(context);
                            }
                          },
                        )
                      ],
                    );
                  });
                },
              ),
              SimpleAlertDialog(
                color: _color,
                onActionPressed: () {
                  Provider.of<TodosModel>(context, listen: false).removeExercise(_exercise);
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
            // child: Column(children: [
            //   Expanded(
            //     child: Padding(
            //       padding: EdgeInsets.only(top: 16.0),
            //       child: ListView.builder(itemBuilder: (BuildContext context, int index) {
            //         // if (index == _rounds.length) { return SizedBox(height: 56); }
            //         _exerciseController.text = widget.name;
            //         previousExerciseVolume = widget.previousVolume;
            //         bestExerciseVolume = widget.bestVolume;
            //         return Container(
            //           padding: EdgeInsets.only(top: 10.0, bottom: 5.0, left: 10.0, right: 10.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Hero(
                              tag: 'title_hero_unused',
                              child: Text(_exercise.name, style: Theme.of(context).textTheme.title.copyWith(color: Colors.black54)),
                            ),
                          ),
                          Container(padding: EdgeInsets.only(top: 30.0, bottom: 0.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(flex: 1, child: Container(height: 5)),
                              Container(width:100, padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                                child: Text('Best', textAlign: TextAlign.center, style: TextStyle(fontSize: 16))
                              ),
                              Container(width:100, padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                                child: Text('Previous', textAlign: TextAlign.center, style: TextStyle(fontSize: 16))
                              ),
                              Container(width: 100, padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                                child: Text('Current', textAlign: TextAlign.center, style: TextStyle(fontSize: 16))
                              ),
                              Expanded(flex: 1, child: Container(height: 5)),
                            ],
                          ),
                        ),
                        Container(padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(flex: 1, child: Container(height: 10)),
                              Container( width:100, padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                                child: Text(bestExerciseVolume.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 16))
                              ),
                              Container( width:100, padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                                child: Text(previousExerciseVolume.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 16))
                              ),
                              Container(width: 100, padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                                child: Text(myCurrentVolume.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 16))
                              ),
                              Expanded(flex: 1, child: Container(height: 10)),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20.0, bottom: 0.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(flex: 1, child: Container(height: 0)),
                              Container(width: 90, padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                                child: Text('Weight', textAlign: TextAlign.center, style: TextStyle(fontSize: 16))
                              ),
                              Container(width: 90, padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                                child: Text('Sets', textAlign: TextAlign.center, style: TextStyle(fontSize: 16))
                              ),
                              Container(width: 90, padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                                child: Text('Reps', textAlign: TextAlign.center, style: TextStyle(fontSize: 16))
                              ),
                              Expanded(flex: 1, child: Container(height: 0)),
                            ],
                          ),
                        ),
                        
                        // RenderRounds(widget.id, _exercise.single, parentUpdater: () => setState(() {})),

                        Column(
                          children: _rounds.map((_round) => 
                            Container(padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                              child: Row(
                                children: <Widget>[
                                    Expanded(
                                      child: new SizedBox(height: 18.0, width: 24.0,
                                        child: new IconButton(
                                          padding: new EdgeInsets.all(0.0),
                                          icon: new Icon(Icons.remove, size: 18.0),
                                          onPressed: () {
                                            _updateCurrentVolume(_round, true);
                                            Provider.of<TodosModel>(context, listen: false).updateRound(_round);

                                             myCurrentVolume = 0;
                                            _rounds.forEach((round) {
                                              myCurrentVolume += (round.weight * round.round * round.rep);
                                            });
                                            Provider.of<TodosModel>(context, listen: false).updateExercise(Exercise(
                                              id: _exercise.id, 
                                              name: _exercise.name, 
                                              completed: _exercise.completed, 
                                              bestVolume: _exercise.bestVolume, 
                                              previousVolume: _exercise.previousVolume,
                                              currentVolume: myCurrentVolume,
                                              dayId: _exercise.dayId, 
                                              weekId: _exercise.weekId, 
                                              programId: _exercise.programId
                                            ));

                                          }
                                        )
                                      ),
                                    ),
                                    FlatButton(color: colors[0],
                                      onPressed: () async {
                                        _selected = [false, false, false];
                                        setState(() {
                                          colors = [Colors.white, Colors.white, Colors.white];
                                          colors[0] = Colors.blue;
                                          _selected[0] = true;
                                        });
                                      },
                                      child: Text(_round.weight.toString())
                                    ),
                                    FlatButton(color: colors[1],
                                    onPressed: () {
                                      _selected = [false, false, false];
                                      setState(() {
                                        colors = [Colors.white, Colors.white, Colors.white];
                                        colors[1] = Colors.blue;
                                        _selected[1] = true;
                                      });
                                    },
                                    child: Text(_round.round.toString())),
                                    FlatButton(color: colors[2],
                                      onPressed: () {
                                        _selected = [false, false, false];
                                        setState(() {
                                          colors = [Colors.white, Colors.white, Colors.white];
                                          colors[2] = Colors.blue;
                                          _selected[2] = true;
                                        });
                                      },
                                      child: Text(_round.rep.toString())
                                    ),
                                    Expanded(
                                      child: new SizedBox(height: 18.0, width: 24.0,
                                        child: new IconButton(
                                          padding: new EdgeInsets.all(0.0),
                                          icon: new Icon(Icons.add, size: 18.0),
                                          onPressed: () {    
                                            _updateCurrentVolume(_round, false);
                                            Provider.of<TodosModel>(context, listen: false).updateRound(_round);

                                            myCurrentVolume = 0;
                                            _rounds.forEach((round) {
                                              myCurrentVolume += (round.weight * round.round * round.rep);
                                            });
                                            Provider.of<TodosModel>(context, listen: false).updateExercise(Exercise(
                                              id: _exercise.id, 
                                              name: _exercise.name, 
                                              completed: _exercise.completed, 
                                              bestVolume: _exercise.bestVolume, 
                                              previousVolume: _exercise.previousVolume,
                                              currentVolume: myCurrentVolume,
                                              dayId: _exercise.dayId, 
                                              weekId: _exercise.weekId, 
                                              programId: _exercise.programId
                                            ));

                                          }
                                        )
                                      )
                                    )
                                  ]
                                )
                              )
                            ).toList()
                          ),     

                              Container(
                                padding: EdgeInsets.only(top: 0.0, bottom: 5.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(flex: 1,
                                      child: new IconButton(
                                        padding: new EdgeInsets.all(0.0),
                                        icon: new Icon(Icons.delete, size: 24.0),
                                        onPressed: () async { 
                                          // DBProvider.db.removeExercise(exercise); setState(() {});
                                          // refreshVolumes(exercise.id, exercise.name);
                                        }
                                      )
                                    ),
                                    Expanded(flex: 1,
                                      child: new IconButton(
                                        padding: new EdgeInsets.all(0.0),
                                        icon: new Icon(Icons.remove_circle, size: 24.0),
                                        onPressed: () async { 
                                          // model.removeRound( Round( weight: 0, round: 0, rep: 0, exerciseId: _exercise.single.id, dayId: _exercise.single.dayId, weekId: _exercise.single.weekId, programId: _exercise.single.programId ) );
                                          // await DBProvider.db.removeRound(exercise.id);
                                          // setState(() {});
                                          // _updateCurrentVolumeOnRemove(_exercise.single);
                                          // refreshVolumes(exercise.id, exercise.name);
                                          Provider.of<TodosModel>(context, listen: false).removeRound(_rounds.last);
                                          // setState(() {});

                                           var _newRounds = programs.allRounds.where((round) => round.exerciseId == widget.id).toList();

                                          myCurrentVolume = 0;
                                          _newRounds.forEach((round) {
                                            myCurrentVolume += (round.weight * round.round * round.rep);
                                          });
                                          Provider.of<TodosModel>(context, listen: false).updateExercise(Exercise(
                                            id: _exercise.id, 
                                            name: _exercise.name, 
                                            completed: _exercise.completed, 
                                            bestVolume: _exercise.bestVolume, 
                                            previousVolume: _exercise.previousVolume,
                                            currentVolume: myCurrentVolume,
                                            dayId: _exercise.dayId, 
                                            weekId: _exercise.weekId, 
                                            programId: _exercise.programId
                                          ));

                                        }
                                      )
                                    ),
                                    Expanded(flex: 1,
                                      child: new IconButton(
                                        padding: new EdgeInsets.all(0.0),
                                        icon: new Icon(Icons.add_circle, size: 24.0),
                                        onPressed: () {
                                          if (_rounds.length > 0) {
                                            Provider.of<TodosModel>(context, listen: false).addRound(Round(
                                              weight: _rounds.last.weight,
                                              round: _rounds.last.round,
                                              rep: _rounds.last.rep,
                                              exerciseId: widget.id, 
                                              dayId: widget.dayId, 
                                              weekId: widget.weekId, 
                                              programId: widget.programId
                                            ));

                                          } else {
                                            Provider.of<TodosModel>(context, listen: false).addRound(Round(
                                              exerciseId: widget.id, 
                                              dayId: widget.dayId, 
                                              weekId: widget.weekId, 
                                              programId: widget.programId
                                            ));
                                          }

                                          var _newRounds = programs.allRounds.where((round) => round.exerciseId == widget.id).toList();

                                          myCurrentVolume = 0;
                                          _newRounds.forEach((round) {
                                            myCurrentVolume += (round.weight * round.round * round.rep);
                                          });
                                          Provider.of<TodosModel>(context, listen: false).updateExercise(Exercise(
                                            id: _exercise.id, 
                                            name: _exercise.name, 
                                            completed: _exercise.completed, 
                                            bestVolume: _exercise.bestVolume, 
                                            previousVolume: _exercise.previousVolume,
                                            currentVolume: myCurrentVolume,
                                            dayId: _exercise.dayId, 
                                            weekId: _exercise.weekId, 
                                            programId: _exercise.programId
                                          ));

                                        },      
                                      )
                                    ),
                                  ],
                                ),
                              )
                        ] 
                      ),

              //       );
              //     }, itemCount: _rounds.length + 1,),
              //   ),
              // ),
            // ]
            // ),
          ),

          // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          // floatingActionButton: Builder(
          //   builder: (BuildContext context) {
          //     return FloatingActionButton.extended(
          //       heroTag: 'fab_new_card',
          //       icon: Icon(Icons.save),
          //       backgroundColor: Colors.blue,
          //       label: Text('Save Exercise'),
          //       onPressed: () {
          //         // if (_exerciseController.text.isEmpty) {
          //         //   final snackBar = SnackBar(
          //         //     content: Text('Ummm... It seems that you are trying to add an invisible program which is not allowed in this realm.'),
          //         //     backgroundColor: Colors.black,
          //         //   );
          //         //   Scaffold.of(context).showSnackBar(snackBar);
          //         //   // _scaffoldKey.currentState.showSnackBar(snackBar);
          //         // } else {
          //           // model.saveExercise(Exercise(
          //           //   id: widget.id,
          //           //   name: widget.name,
          //           //   bestVolume: widget.bestVolume,
          //           //   previousVolume: widget.previousVolume,
          //           //   currentVolume: widget.currentVolume,
          //           //   round: _exercise.single.round,
          //           //   dayId: widget.dayId,
          //           //   weekId: widget.weekId,
          //           //   programId: widget.programId
          //           // ));
          //           Navigator.pop(context);
          //         // }
          //       },
          //     );
          //   },
          // ),

        )
      );
    });
  }
}


typedef void Callback();

class SimpleAlertDialog extends StatelessWidget {
  final Color color;
  final Callback onActionPressed;

  SimpleAlertDialog({
    @required this.color,
    @required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: color,
      icon: Icon(Icons.delete),
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Delete this Program?'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('This is a one way street! Deleting this will remove all the program assigned in this card.'),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Delete'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    onActionPressed();
                  },
                ),
                FlatButton(
                  child: Text('Cancel'),
                  textColor: Colors.grey,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
