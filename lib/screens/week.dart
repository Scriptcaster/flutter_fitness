// import 'package:bench_more/component/week_badge.dart';
// import 'package:bench_more/models/program.dart';
// import 'package:bench_more/models/week.dart';
// import 'package:bench_more/utils/color_utils.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_fitness/screens/program.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// import 'package:scoped_model/scoped_model.dart';
import '../models/day.dart';
// import '../db/db_provider.dart';
// import 'day.dart';

import '../models/hero_id.dart';
import '../models/week.dart';
import 'package:flutter_fitness/providers/provider.dart';

// import '../task_progress_indicator.dart';

// import '../scopedmodel/program.dart';

class WeekScreen extends StatefulWidget {
  WeekScreen({ this.id, this.name, this.completed, this.date, this.programId });
  final int id;
  final String name;
  final int completed;
  final int date;
  final int programId;

  // final String taskId;
  // final HeroId heroIds;
  // final Color color;

  // var _color = ColorUtils.getColorFrom(id: _program.color);
   
  @override
  _WeekScreenState createState() => _WeekScreenState();
}

class _WeekScreenState extends State<WeekScreen> { 
  
  TextEditingController _newNameController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // return ScopedModelDescendant<WeekListModel>(
    //   builder: (BuildContext context, Widget child, WeekListModel model) {
       return Consumer<TodosModel>(builder: (context, programs, child) {
         
        Week _week;
        // Day _day;
       
        // print(_week.toJson());
        // _week = model.weeks.firstWhere((day) => day.id == widget.id);
        // print(model.weeks);
        // _day = model.days.firstWhere((day) => day.probramId == widget.id);
        // print(model.days);

         try {
           _week = programs.weeks.firstWhere((week) => week.id == widget.id, orElse: () => null);
           print(_week.toJson());
          // print(_program.toJson());
        } catch (e) {
          return Container(
            color: Colors.white,
          );
        }

        var _color = Colors.green;
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black26),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                icon: Icon(Icons.edit),
                color: _color,
                onPressed: () {


                showDialog(
                context: context,
                builder: (BuildContext context) {
                  _newNameController.text = _week.name;
                  return AlertDialog(
                    title: Text("New Week"),
                    content: TextField(
                      style: new TextStyle(fontSize: 20.0, color: Colors.blue),
                      keyboardType: TextInputType.text,
                      controller: _newNameController,
                      onSubmitted: (value) => _newNameController.text = value,
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Close"),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      FlatButton(
                        child: Text("Save"),
                        onPressed: () {
                          if (_newNameController.text.isEmpty) {
                            final snackBar = SnackBar(
                              content: Text('Ummm... It seems that you are trying to add an invisible program which is not allowed in this realm.'),
                              backgroundColor: _color,
                            );
                            Scaffold.of(context).showSnackBar(snackBar);
                          } else {
                            // print():
                            Provider.of<TodosModel>(context, listen: false).updateWeek(Week(id: _week.id, name: _newNameController.text, completed: _week.completed, date: _week.completed, programId: _week.programId));
                            // model.addWeek(Week(
                            //   _weekNameController.text,
                            //   program: _program.id,
                            // ));
                            // Navigator.pop(context);
                          }
                        },
                      )
                    ],
                  );
                });

                  // Navigator.push(

                    
                    // SimpleAlertDialog(
                    //   color: _color,
                    //   onActionPressed: () {
                    //     Provider.of<TodosModel>(context, listen: false).removeProgram(_program);
                    //     Navigator.of(context).pop(true);
                    //   },
                    // ),
                    // context,
                    // MaterialPageRoute(
                    //   builder: (context) => EditProgramScreen(
                    //     id: _program.id,
                    //     name: _program.name,
                    //   ),
                    // ),
                  // );
                },
              ),
              //  IconButton(
              //   icon: Icon(Icons.add),
              //   onPressed: () {
              //     // Provider.of<TodosModel>(context, listen: false).addProgram(Program(id: 0, name: 'First Program', completed: 0 ));
              //     Provider.of<TodosModel>(context, listen: false).removeWeek(_week);
              //     Navigator.of(context).pop(true);
              //   },
              // ),
              SimpleAlertDialog(
                color: _color,
                onActionPressed: () {
                  Provider.of<TodosModel>(context, listen: false).removeWeek(_week);
                  Navigator.of(context).pop(true);
                  // Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
            child: Column(children: [
              Container(
                child: Hero(
                  tag: 'title_hero_unused',//_hero.titleId,
                  child: Text(_week.name, style: Theme.of(context).textTheme.title.copyWith(color: Colors.black54)),
                ),
              ),
              // Container(margin: EdgeInsets.symmetric(horizontal: 36.0, vertical: 0.0), height: 160,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       // TodoBadge(color: _color, codePoint: _program.codePoint, id: _hero.codePointId),
              //       Spacer(flex: 1),
              //       Container(margin: EdgeInsets.only(bottom: 4.0),
              //         // child: Hero(tag: _hero.remainingTaskId,
              //           child: Text(DateFormat('MMM d').format(DateTime.fromMillisecondsSinceEpoch(widget.date)).toString()
              //             // "${model.getTotalTodosFrom(_program)} Weeks",
              //             // style: Theme.of(context).textTheme.body1.copyWith(color: Colors.grey[500]),
              //           ),
              //         // ),
              //       ),
              //       Container(          
              //         child: Text(
              //           widget.name, style: Theme.of(context).textTheme.title.copyWith(color: Colors.black54)
              //         ),
              //       ),
              //       Spacer(),
              //       Hero(tag: widget.heroIds.progressId,
              //         child: TaskProgressIndicator(
              //           color: widget.color,
              //           progress: 54,
              //         ),
              //       )
              //     ]
              //   )
              // ),
              // Expanded(
              //   child: Padding(
              //     padding: EdgeInsets.only(top: 16.0),
              //     child: FutureBuilder<List<Day>>(
              //       future: DBProvider.db.getAllDays(widget.id),
              //       builder: (BuildContext context, AsyncSnapshot<List<Day>> snapshot) {
              //         if (snapshot.hasData) {
              //           return ListView.builder(itemCount: snapshot.data.length, itemBuilder: (BuildContext context, int index) {
              //             Day day = snapshot.data[index];
              //             return Dismissible(
              //               key: UniqueKey(),
              //               background: Container(color: Colors.red),
              //               onDismissed: (direction) => DBProvider.db.removeDay(day), 
              //               child: ListTile(
              //                 leading: Checkbox(
              //                   onChanged: (value) {
              //                     setState(() {
              //                       DBProvider.db.updateDay( day.copy(isCompleted: value ? 1 : 0) );
              //                     });
              //                   },
              //                   value: day.isCompleted == 1 ? true : false
              //                 ),
              //                 title: Text(day.dayName.toString()),
              //                 subtitle: Text(day.target.toString()),
              //                 trailing: Icon(Icons.chevron_right),
              //                 onTap: () async {
              //                   setState(() {});
              //                   await Navigator.push( context, MaterialPageRoute(
              //                     builder: (context) => DayLocal(id: day.id, dayName: day.dayName, target: day.target, weekId: day.weekId, programId: day.programId),
              //                   ));
              //                 }
              //               )
              //             );
              //           });
              //         } else {
              //           return Center(child: CircularProgressIndicator());
              //         }
              //       }
              //     )
              //   )
              // )
            ])
          )

        );
      },
    );
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
          barrierDismissible: false, // user must tap button!
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
