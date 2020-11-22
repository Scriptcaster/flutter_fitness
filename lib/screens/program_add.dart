import 'package:flutter/material.dart';
import 'package:flutter_fitness/providers/provider.dart';
import 'package:provider/provider.dart';
// import 'package:scoped_model/scoped_model.dart';

// import '../scopedmodel/program.dart';
import '../models/program.dart';
// import '../component/iconpicker/icon_picker_builder.dart';
// import '../component/colorpicker/color_picker_builder.dart';
import '../utils/color_utils.dart';

class AddProgramScreen extends StatefulWidget {
  @override
  _AddProgramScreenState createState() => _AddProgramScreenState();
}

class _AddProgramScreenState extends State<AddProgramScreen> {
  final taskTitleController = TextEditingController();
  bool completedStatus = false;

  String newTask;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Color taskColor;
  IconData taskIcon;

  @override
  void initState() {
    super.initState();
    setState(() {
      newTask = '';
      taskColor = ColorUtils.defaultColors[0];
      // taskIcon = Icons.work;
    });
  }

  void dispose() {
    taskTitleController.dispose();
    super.dispose();
  }

  void onAdd() {
    final String textVal = taskTitleController.text;
    final bool completed = completedStatus;
    if (textVal.isNotEmpty) {
      final Program program = Program(
        // id: '3',
        name: textVal,
        // completed: 0
      );
      Provider.of<TodosModel>(context, listen: false).addProgram(program);
      Navigator.pop(context);
    }
  }



    // return Scaffold(
      // appBar: AppBar(
      //   title: Text('Add Program'),
      // ),
      // body: ListView(
      //   children: <Widget>[
      //     Padding(
      //       padding: EdgeInsets.all(15.0),
      //       child: Container(
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.stretch,
      //           children: <Widget>[
      //             TextField(controller: taskTitleController),
      //             CheckboxListTile(
      //               value: completedStatus,
      //               onChanged: (checked) => setState(() {
      //                 completedStatus = checked;
      //               }),
      //               title: Text('Complete?'),
      //             ),
      //             RaisedButton(
      //               child: Text('Add'),
      //               onPressed: onAdd,
      //             ),
      //           ],
      //         ),
      //       ),
      //     )
      //   ],
      // ),
    // );
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodosModel>(builder: (context, programs, child) {
      // builder: (BuildContext context, Widget child, WeekListModel model) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'New Program',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black26),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
          ),
          body: Container(
            constraints: BoxConstraints.expand(),
            padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Program will help you group related program!',
                  style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0),
                ),
                Container(
                  height: 16.0,
                ),
                TextField(
                  onChanged: (text) {
                    setState(() => newTask = text);
                  },
                  cursorColor: Colors.black,
                  autofocus: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Program Name...',
                    hintStyle: TextStyle(
                      color: Colors.black26,
                    )),
                  textCapitalization: TextCapitalization.sentences,
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 28.0),
                ),
                Container(
                  height: 26.0,
                ),
                // Row(
                //   children: [
                //     ColorPickerBuilder(
                //       color: taskColor,
                //       onColorChanged: (newColor) => setState(() => taskColor = newColor)),
                //     Container(
                //       width: 22.0,
                //     ),
                //     IconPickerBuilder(
                //       iconData: taskIcon,
                //       highlightColor: taskColor,
                //       action: (newIcon) => setState(() => taskIcon = newIcon)),
                //   ],
                // ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Builder(
            builder: (BuildContext context) {
              return FloatingActionButton.extended(
                heroTag: 'fab_new_card',
                icon: Icon(Icons.save),
                backgroundColor: taskColor,
                label: Text('Create New Program'),
                onPressed: () {
                  if (newTask.isEmpty) {
                    final snackBar = SnackBar(
                      content: Text(
                        'Ummm... It seems that you are trying to add an invisible program which is not allowed in this realm.'),
                      backgroundColor: taskColor,
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                    // _scaffoldKey.currentState.showSnackBar(snackBar);
                  } else {
                    final Program program = Program(name: newTask);
                    Provider.of<TodosModel>(context, listen: false).addProgram(program);
                    Navigator.pop(context);
                  }
                }
              );
            },
          ),
        );
      
      // };

    });
  }
}
// Reason for wraping fab with builder (to get scafold context)
// https://stackoverflow.com/a/52123080/4934757
