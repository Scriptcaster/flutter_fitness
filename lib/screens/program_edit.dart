import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:scoped_model/scoped_model.dart';

// import '../providers/provider.dart';
// import '../scopedmodel/program.dart';
import '../models/program.dart';
import '../models/program.dart';
import '../providers/provider.dart';
// import '../component/iconpicker/icon_picker_builder.dart';
// import '../component/colorpicker/color_picker_builder.dart';

class EditProgramScreen extends StatefulWidget {
  final int id;
  final String name;
  // final Color color;
  // final IconData icon;

  EditProgramScreen({
    @required this.id, 
    @required this.name, 
    // @required this.color, 
    // @required this.icon
  });

  @override
  State<StatefulWidget> createState() {
    return _EditProgramScreenState();
  }
}

class _EditProgramScreenState extends State<EditProgramScreen> {
  final  btnSaveTitle = "Save Changes";
  String newTask;
  Color taskColor;
  IconData taskIcon;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      newTask = widget.name;
      // taskColor = widget.color;
      // taskIcon = widget.icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return ScopedModelDescendant<WeekListModel>(
    //   builder: (BuildContext context, Widget child, WeekListModel model) {
      return Consumer<TodosModel>(builder: (context, programs, child) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Edit Category',
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
                  'Category will help you group related program!',
                  style: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0),
                ),
                Container(
                  height: 16.0,
                ),
                TextFormField(
                  initialValue: newTask,
                  onChanged: (text) {
                    setState(() => newTask = text);
                  },
                  cursorColor: taskColor,
                  autofocus: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Category Name...',
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      )),
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 24.0),
                ),
                Container(height: 26.0),
                // Row(
                //   children: [
                //     ColorPickerBuilder(
                //         color: taskColor,
                //         onColorChanged: (newColor) => setState(() => taskColor = newColor)),
                //     Container(
                //       width: 22.0,
                //     ),
                //     IconPickerBuilder(
                //         iconData: taskIcon,
                //         highlightColor: taskColor,
                //         action: (newIcon) => setState(() => taskIcon = newIcon)),
                //   ],
                // ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Builder(
            builder: (BuildContext context) {
              return FloatingActionButton.extended(
                heroTag: 'fab_new_card',
                icon: Icon(Icons.save),
                backgroundColor: taskColor,
                label: Text(btnSaveTitle),
                onPressed: () {
                  if (newTask.isEmpty) {
                    final snackBar = SnackBar(
                      content: Text('Ummm... It seems that you are trying to add an invisible program which is not allowed in this realm.'),
                      backgroundColor: taskColor,
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                    // _scaffoldKey.currentState.showSnackBar(snackBar);
                  } else {
                    Provider.of<TodosModel>(context, listen: false).updateProgram(Program(id: widget.id, name: newTask));
                    // model.updateProgram(Program(
                    //   newTask,
                    //   codePoint: taskIcon.codePoint,
                    //   color: taskColor.value,
                    //   id: widget.taskId
                    // ));
                    Navigator.pop(context);
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}

// Reason for wraping fab with builder (to get scafold context)
// https://stackoverflow.com/a/52123080/4934757
