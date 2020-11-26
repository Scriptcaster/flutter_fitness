import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'exercise.dart';
import '../models/day.dart';
import '../models/exercise.dart';
import '../providers/provider.dart';
import 'exercise.dart';

// import 'package:scoped_model/scoped_model.dart';
// import '../scopedmodel/program.dart';

class DayScreen extends StatefulWidget {
  DayScreen({this.id, this.name,  this.target, this.completed, this.weekId, this.programId});
  final int id;
  final String name;
  final String target;
  final int completed;
  final int weekId;
  final int programId;

  @override
  _StartDayScreenState createState() => _StartDayScreenState();
}
class _StartDayScreenState extends State<DayScreen> { _StartDayScreenState();
  TextEditingController _targetController = TextEditingController();
  TextEditingController _exerciseController = TextEditingController();

  @override
  void initState() {
    _targetController.text = widget.target;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodosModel>(builder: (context, programs, child) {
      Day _day;
      try {
        _day = programs.days.firstWhere((day) => day.id == widget.id, orElse: () => null);
        // print(_day.toJson());
      } catch (e) {
        return Container(
          color: Colors.white,
        );
      }
      var _exercises = programs.allExercises.where((exercise) => exercise.dayId == widget.id).toList();
      // return WillPopScope(
      var _color = Colors.pink;
      return Theme(
        data: ThemeData(primarySwatch: _color),
        child: Scaffold(
           backgroundColor: Colors.white,
        // key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: _color),
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showDialog( context: context, builder: (BuildContext context) {
                  _targetController.text = widget.target;
                  return AlertDialog(
                    title: Text("Edit Week"),
                    content: TextField(
                      style: new TextStyle(fontSize: 20.0),
                      keyboardType: TextInputType.text,
                      controller: _targetController,
                      onSubmitted: (value) => _targetController.text = value,
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Close"),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      FlatButton(
                        child: Text("Save"),
                        onPressed: () {
                          if (_targetController.text.isEmpty) {
                          } else {
                            Provider.of<TodosModel>(context, listen: false).updateDay(Day(
                              id: widget.id, 
                              name: _day.name, 
                              target: _targetController.text, 
                              completed: _day.completed, 
                              weekId: _day.weekId, 
                              programId: _day.programId
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
                  Provider.of<TodosModel>(context, listen: false).removeDay(_day);
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
            child: Column(children: [
              Container(
                child: Hero(
                  tag: 'title_hero_unused',
                  child: Text(_day.target, style: Theme.of(context).textTheme.title.copyWith(color: Colors.black54)),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      // _weeks.sort((a, b) => b.id.compareTo(a.id));
                      if (index == _exercises.length) {
                        return SizedBox(height: 56);
                      }
                      var exercise = _exercises[index];
                     
                      return ListTile(
                        onTap: () {
                          Navigator.push( context,
                            MaterialPageRoute(
                              builder: (context) => ExerciseScreen(
                                id: exercise.id,
                                name: exercise.name,
                                bestVolume: exercise.bestVolume,
                                previousVolume: exercise.previousVolume,
                                currentVolume: exercise.currentVolume,
                                dayId: exercise.dayId,
                                weekId: exercise.weekId,
                                programId: exercise.programId
                              ),
                            ),
                          );
                        },
                        leading: Checkbox(
                          onChanged: (value) => Provider.of<TodosModel>(context, listen: false).toggleExercise(exercise),
                          value: _exercises[index].completed == 1 ? true : false,
                        ),
                        title: Text(
                          _exercises[index].name,
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          _exercises[index].id.toString(), 
                        ),
                        trailing: Icon(Icons.chevron_right, color: Colors.black54),
                      );
                    }, itemCount: _exercises.length + 1,
                  ),
                ),
              ),

            ])
          ),

            floatingActionButton: FloatingActionButton(
              heroTag: 'fab_new_week',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    _exerciseController.text = "";
                    return AlertDialog(
                      title: Text("New Exercise"),
                      content: TextField(
                        style: new TextStyle(fontSize: 20.0, color: Colors.blue),
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
                              final snackBar = SnackBar(
                                content: Text('Ummm... It seems that you are trying to add an invisible week which is not allowed in this realm.'),
                                backgroundColor: _color,
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                            } else {
                              Provider.of<TodosModel>(context, listen: false).addExercise(Exercise(name: _exerciseController.text, dayId: widget.id, weekId: widget.weekId, programId: widget.programId));
                              Navigator.pop(context);
                            }
                          },
                        )
                      ],
                    );
                  }
                );
              },
              tooltip: 'New Week',
              backgroundColor: _color,
              foregroundColor: Colors.white,
              child: Icon(Icons.add),
            ),

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
