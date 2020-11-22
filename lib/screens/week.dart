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
        Day _day;
       
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
            color: Colors.black,
          );
        }
        // programs.allDays.forEach((element) { 
        //   print(element.toJson());
        // });
        var _days = programs.allDays.where((day) => day.weekId == widget.id).toList();
        var _color = Colors.white;
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black26),
            brightness: Brightness.light,
            backgroundColor: Colors.blue,
            actions: [
              IconButton(
                icon: Icon(Icons.edit),
                color: _color,
                onPressed: () {


                  showDialog( context: context, builder: (BuildContext context) {
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
             
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    // _weeks.sort((a, b) => b.id.compareTo(a.id));
                    if (index == _days.length) {
                      return SizedBox(height: 56);
                    }
                    var day = _days[index];
                    return Dismissible(
                      key: UniqueKey(),
                      background: Container(color: Colors.red),
                      confirmDismiss: (DismissDirection direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirm Removal"),
                              content: const Text("Are you sure you wish to delete this item?"),
                              actions: <Widget>[
                                // FlatButton(
                                //     child: const Text("DELETE"),
                                //     onPressed: () {
                                //       model.removeWeek(week);
                                //       Navigator.of(context).pop(true);
                                //     }),
                                // FlatButton(
                                //   onPressed: () =>
                                //       Navigator.of(context).pop(false),
                                //   child: const Text("CANCEL"),
                                // ),
                              ],
                            );
                          },
                        );
                      },
                      child: ListTile(
                        onTap: () {
                          Navigator.push( context,
                            MaterialPageRoute(
                              // builder: (context) => WeekScreen(
                              //   id: week.id,
                              //   name: week.name,
                              //   completed: week.completed,
                              //   date: week.date,
                              //   programId: _program.id
                              // ),
                            ),
                          );
                        },
                        // onTap: () => model.updateTodo(week.copy(isCompleted: week.isCompleted == 1 ? 0 : 1)),
                        // contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),

                        leading: Checkbox(
                          onChanged: (value) => Provider.of<TodosModel>(context, listen: false).toggleDay(day),
                          value: day.completed == 1 ? true : false,
                          checkColor: Colors.yellowAccent,
                          activeColor: day.completed == 1 ? Colors.green: Colors.black ,
                        ),

                        title: Text(
                          day.name,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: day.completed == 1 ? _color : Colors.black54,
                            decoration: day.completed == 1 ? TextDecoration.lineThrough : TextDecoration.none,
                          ),
                        ),
                        subtitle: Text(day.target, style: TextStyle(color: Colors.black54)),
                        trailing: Icon(Icons.chevron_right, color: Colors.black54),

                       
                      ),
                    );
                  },
                  itemCount: _days.length + 1,
                ),
              ),
              ),



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
