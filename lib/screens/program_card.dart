import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:flutter_fitness/models/program.dart';
import 'package:flutter_fitness/providers/provider.dart';

class ProgramCard extends StatelessWidget {
  final Program program;
  final GlobalKey backdropKey;

  ProgramCard({
    @required this.program,
     @required this.backdropKey,
  });

  @override
  Widget build(BuildContext context) {
    // return ListTile(
    //   leading: Checkbox(
    //     // value: program.completed,
    //     value: program.completed == 1 ? true : false,
    //     onChanged: (bool checked) {
    //       Provider.of<TodosModel>(context, listen: false).toggleProgram(program);
    //     },
    //   ),
    //   title: Text(program.name),
    //   trailing: IconButton(
    //     icon: Icon(
    //       Icons.delete,
    //       color: Colors.red,
    //     ),
    //     onPressed: () {
    //       Provider.of<TodosModel>(context, listen: false).removeProgram(program);
    //     },
    //   ),
    // );


    return GestureDetector(
      onTap: () {
        final RenderBox renderBox = backdropKey.currentContext.findRenderObject();
        var backDropHeight = renderBox.size.height;
        var bottomOffset = 40.0;
        var horizontalOffset = 40.0;
        var topOffset = MediaQuery.of(context).size.height - backDropHeight;
        var rect = RelativeRect.fromLTRB(horizontalOffset, topOffset, horizontalOffset, bottomOffset);
        // Navigator.push(
        //   context,
        //   // ScaleRoute(
        //   //   rect: rect,
        //   //   widget: DetailScreen(
        //   //     taskId: program.id,
        //   //     heroIds: heroIds,
        //   //   ),
        //   // ),
        //   // MaterialPageRoute(
        //   //   builder: (context) => DetailScreen(
        //   //         taskId: program.id,
        //   //         heroIds: heroIds,
        //   //       ),
        //   // ),
        // );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        elevation: 4.0,
        margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // TodoBadge(
              //   id: heroIds.codePointId,
              //   codePoint: program.codePoint,
              //   color: ColorUtils.getColorFrom(
              //     id: program.color,
              //   ),
              // ),
              Spacer(
                flex: 8,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 4.0),
                child: Hero(
                  tag: 'tag',
                  child: Text(DateFormat('MMM d').format(DateTime.fromMillisecondsSinceEpoch(program.date)).toString(), style: Theme.of(context).textTheme.body1.copyWith(color: Colors.grey[500]),
                  ),
                ),
              ),
              Container(
                child: Hero(
                  tag: 'tag',
                  child: Text(program.name, style: Theme.of(context).textTheme.title.copyWith(color: Colors.black54)),
                ),
              ),
              Spacer(),
              // Hero(
              //   tag: heroIds.progressId,
              //   child: TaskProgressIndicator(
              //     color: color,
              //     progress: getTaskCompletionPercent(program),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );

  }
}
