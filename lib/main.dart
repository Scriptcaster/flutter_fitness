import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_fitness/screens/home.dart';
import 'package:flutter_fitness/providers/provider.dart';

void main() => runApp(TodosApp());

class TodosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => TodosModel(),
      child: MaterialApp(
        title: 'Fitness App',
        theme: ThemeData.dark(),
        // home: HomeScreen(),
        home: Home(),
      ),
    );
  }
}
