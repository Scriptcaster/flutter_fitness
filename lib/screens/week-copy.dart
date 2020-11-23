// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_fitness/providers/provider.dart';
// import '../models/day.dart';
// import '../models/week.dart';
// import 'day.dart';


// class WeekScreen extends StatefulWidget {
//   WeekScreen({ this.id, this.name, this.completed, this.date, this.programId });
//   final int id;
//   final String name;
//   final int completed;
//   final int date;
//   final int programId;
   
//   @override
//   _WeekScreenState createState() => _WeekScreenState();
// }

// class _WeekScreenState extends State<WeekScreen> { 
  
//   TextEditingController _weekNameController = TextEditingController();

//   TextEditingController _dayNameController = TextEditingController();

//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<TodosModel>(builder: (context, programs, child) {
//     Week _week;
//     try {
//       _week = programs.weeks.firstWhere((week) => week.id == widget.id, orElse: () => null);
//     } catch (e) {
//       return Container(
//         color: Colors.white,
//       );
//     }
//     var _color = Colors.pink;
//     var _days = programs.allDays.where((day) => day.weekId == widget.id).toList();
//    return Theme(
//       data: ThemeData(primarySwatch: _color),
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           iconTheme: IconThemeData(color: _color),
//           brightness: Brightness.light,
//           actions: [
//             IconButton(
//               icon: Icon(Icons.edit),
//               color: _color,
//               onPressed: () {
//                 showDialog( context: context, builder: (BuildContext context) {
//                   _weekNameController.text = _week.name;
//                   return AlertDialog(
//                     title: Text("New Week"),
//                     content: TextField(
//                       style: new TextStyle(fontSize: 20.0),
//                       keyboardType: TextInputType.text,
//                       controller: _weekNameController,
//                       onSubmitted: (value) => _weekNameController.text = value,
//                     ),
//                   actions: <Widget>[
//                     FlatButton(
//                       child: Text("Close"),
//                       onPressed: () => Navigator.of(context).pop(),
//                     ),
//                     FlatButton(
//                       child: Text("Save"),
//                       onPressed: () {
//                         if (_weekNameController.text.isEmpty) {
//                           final snackBar = SnackBar(
//                             content: Text('Ummm... It seems that you are trying to add an invisible program which is not allowed in this realm.'),
//                             // backgroundColor: _color,
//                           );
//                           Scaffold.of(context).showSnackBar(snackBar);
//                         } else {
//                           // print():
//                           Provider.of<TodosModel>(context, listen: false).updateWeek(Week(id: _week.id, name: _weekNameController.text, completed: _week.completed, date: _week.completed, programId: _week.programId));
//                           // model.addWeek(Week(
//                           //   _weekNameController.text,
//                           //   program: _program.id,
//                           // ));
//                           Navigator.pop(context);
//                         }
//                       },
//                     )
//                   ],
//                 );
//               });
//             },
//           ),
//               SimpleAlertDialog(
//                 color: _color,
//                 onActionPressed: () {
//                   Provider.of<TodosModel>(context, listen: false).removeWeek(_week);
//                   Navigator.of(context).pop(true);
//                 },
//               ),
//             ],
//           ),
//           body: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
//             child: Column(children: [
//               Container(
//                 child: Hero(
//                   tag: 'title_hero_unused',
//                   child: Text(_week.name, style: Theme.of(context).textTheme.title.copyWith(color: Colors.black54)),
//                 ),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.only(top: 16.0),
//                   child: ListView.builder(
//                     itemBuilder: (BuildContext context, int index) {
//                       // _weeks.sort((a, b) => b.id.compareTo(a.id));
//                       if (index == _days.length) {
//                         return SizedBox(height: 56);
//                       }
//                       var day = _days[index];
                     
//                       return ListTile(
//                         onTap: () {
//                           Navigator.push( context,
//                             MaterialPageRoute(
//                               builder: (context) => DayScreen(
//                                 id: day.id,
//                                 name: day.name,
//                                 target: day.target,
//                                 completed: day.completed,
//                                 weekId: day.weekId,
//                                 programId: day.programId
//                               ),
//                             ),
//                           );
//                         },
//                         leading: Checkbox(
//                           onChanged: (value) => Provider.of<TodosModel>(context, listen: false).toggleDay(day),
//                           value: day.completed == 1 ? true : false,
//                         ),
//                         title: Text(
//                           day.name,
//                           style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
//                         ),
//                         subtitle: Text(day.target, 
//                         ),
//                         trailing: Icon(Icons.chevron_right, color: Colors.black54),
//                       );
//                     }, itemCount: _days.length + 1,
//                   ),
//                 ),
//               ),

//             ])
//           ),


//           floatingActionButton: FloatingActionButton(
//               heroTag: 'fab_new_program',
//               onPressed: () {
//                 showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   // _weekNameController.text = "Week ${model.getTotalTodosFrom(_program) + 1}";
//                   // _weekNameController.text = "New Week Name";
//                   _dayNameController.text = "";
//                   return AlertDialog(
//                     title: Text("New Day"),
//                     content: TextField(
//                       style: new TextStyle(fontSize: 20.0, color: Colors.black),
//                       keyboardType: TextInputType.text,
//                       controller: _dayNameController,
//                       onSubmitted: (value) => _dayNameController.text = value,
//                     ),
//                     actions: <Widget>[
//                       FlatButton(
//                         child: Text("Close"),
//                         onPressed: () => Navigator.of(context).pop(),
//                       ),
//                       FlatButton(
//                         child: Text("Save"),
//                         onPressed: () {
//                           if (_weekNameController.text.isEmpty) {
//                             final snackBar = SnackBar(
//                               content: Text('Ummm... It seems that you are trying to add an invisible program which is not allowed in this realm.'),
//                               backgroundColor: _color,
//                             );
//                             Scaffold.of(context).showSnackBar(snackBar);
//                           } else {
//                             // print():
//                             Provider.of<TodosModel>(context, listen: false).addDay(Day(name: _dayNameController.text, target: _dayNameController.text, weekId: widget.id, programId: _week.programId));
//                             // model.addWeek(Week(
//                             //   _weekNameController.text,
//                             //   program: _program.id,
//                             // ));
//                             Navigator.pop(context);
//                           }
//                         },
//                       )
//                     ],
//                   );
//                 });
//               },
//               tooltip: 'New Day',
//               backgroundColor: _color,
//               foregroundColor: Colors.white,
//               child: Icon(Icons.add),
//             )

//           )
//         );  
//       }
//     );
//   }

// }

// typedef void Callback();

// class SimpleAlertDialog extends StatelessWidget {
//   final Color color;
//   final Callback onActionPressed;

//   SimpleAlertDialog({
//     @required this.color,
//     @required this.onActionPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       color: color,
//       icon: Icon(Icons.delete),
//       onPressed: () {
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Delete this Program?'),
//               content: SingleChildScrollView(
//                 child: ListBody(
//                   children: <Widget>[
//                     Text('This is a one way street! Deleting this will remove all the program assigned in this card.'),
//                   ],
//                 ),
//               ),
//               actions: <Widget>[
//                 FlatButton(
//                   child: Text('Delete'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     onActionPressed();
//                   },
//                 ),
//                 FlatButton(
//                   child: Text('Cancel'),
//                   textColor: Colors.grey,
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }
