import 'package:flutter/material.dart';

import 'package:flutter_fitness/models/program.dart';
import 'package:flutter_fitness/screens/program_card.dart';

class ProgramCards extends StatelessWidget {
  final List<Program> programs;
  final GlobalKey backdropKey;
  // final Color color;

  ProgramCards({
    @required this.programs,
    @required this.backdropKey,
    // @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: programs.map((program) => ProgramCard(program: program, backdropKey: backdropKey)).toList(),
    );
  }
}