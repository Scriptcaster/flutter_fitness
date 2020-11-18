import 'package:flutter/material.dart';

import 'package:flutter_fitness/models/program.dart';
import 'package:flutter_fitness/widgets/task_list_item.dart';

class ProgramList extends StatelessWidget {
  final List<Program> programs;

  ProgramList({@required this.programs});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getChildrenPrograms(),
    );
  }

  List<Widget> getChildrenPrograms() {
    return programs.map((program) => ProgramListItem(program: program)).toList();
  }
}
