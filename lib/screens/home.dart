import 'package:flutter/material.dart';
import 'package:flutter_fitness/utils/gradient_background.dart';
import 'package:provider/provider.dart';
import 'package:flutter_fitness/models/program.dart';

import '../providers/provider.dart';

import '../widgets/task_list.dart';

import 'add_program.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
    Provider.of<TodosModel>(context, listen: false).getPrograms();
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
        color: Colors.pink,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Fitness App'),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  // Provider.of<TodosModel>(context, listen: false).addProgram(Program(id: 0, name: 'First Program', completed: 0 ));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddProgramScreen(),
                    ),
                  );
                },
              ),
            ],
          ),

          body: Container(
            child: Consumer<TodosModel>(
              builder: (context, programs, child) => ProgramList(
                programs: programs.allPrograms,
              ),
            ),
          ),

        ),
      );
  }
}

