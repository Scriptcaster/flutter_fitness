import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_fitness/models/program.dart';
import 'package:flutter_fitness/providers/provider.dart';

class ProgramListItem extends StatelessWidget {
  final Program program;

  ProgramListItem({@required this.program});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        // value: program.completed,
        value: program.completed == 1 ? true : false,
        onChanged: (bool checked) {
          Provider.of<TodosModel>(context, listen: false).toggleProgram(program);
        },
      ),
      title: Text(program.name),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () {
          Provider.of<TodosModel>(context, listen: false).deleteProgram(program);
        },
      ),
    );
  }
}
