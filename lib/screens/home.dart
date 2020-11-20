import 'package:flutter/material.dart';
import 'package:flutter_fitness/screens/program_card_add.dart';
import 'package:flutter_fitness/screens/program_card.dart';
import 'package:flutter_fitness/screens/program_card.dart';
import 'package:flutter_fitness/utils/datetime_utils.dart';
import 'package:flutter_fitness/utils/gradient_background.dart';
import 'package:provider/provider.dart';
import 'package:flutter_fitness/models/program.dart';

import '../providers/provider.dart';

import '../providers/provider.dart';
import '../providers/provider.dart';
import '../providers/provider.dart';
// import 'program_cards.dart';

import 'add_program.dart';

import 'package:flutter_fitness/utils/color_utils.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  String currentDay(BuildContext context) {
    return DateTimeUtils.currentDay;
  }

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  PageController _pageController;
  int _currentPageIndex = 0;
  int _total;
  @override
  void initState() {
    super.initState();
    // loadChart();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
    Provider.of<TodosModel>(context, listen: false).getPrograms();
    // refreshVolumes();
    getTotal();
  }

  getTotal() async {
    _total = await TodosModel().getTotal();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodosModel>(builder: (context, programs, child) {
      // Animation<double> _animation;
      var _programs = programs.programs;
      
      var _isLoading = false;
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

          // body: Container(
          //   child: Consumer<TodosModel>(
          //     builder: (context, programs, child) => ProgramList(
          //       programs: programs.allPrograms,
          //     ),
          //   ),
          // ),

          body: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1.0,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              :
              // FadeTransition(
              //     opacity: Tween<double>(begin: 0.0, end: 1.0).animate(_controller),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 0.0, left: 56.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // ShadowImage(),
                          Container(
                            margin: EdgeInsets.only(top: 22.0),
                            child: Text('${widget.currentDay(context)}', style: Theme.of(context).textTheme.headline.copyWith(color: Colors.white),),
                          ),
                          Text('${DateTimeUtils.currentDate} ${DateTimeUtils.currentMonth}', style: Theme.of(context).textTheme.title.copyWith( color: Colors.white.withOpacity(0.7))),
                          Container(height: 16.0),
                          Text('You have $_total programs to complete', style: Theme.of(context).textTheme.body1.copyWith( color: Colors.white.withOpacity(0.7))),
                          // Container(child: SubscriberChart(data: newData)),
                        ],
                      ),
                    ),
                    Expanded(
                      key: _backdropKey,
                      flex: 1,
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification is ScrollEndNotification) {
                            var currentPage =
                                _pageController.page.round().toInt();
                            if (_currentPageIndex != currentPage) {
                              setState(() => _currentPageIndex = currentPage);
                            }
                          }
                        },

                        child: PageView.builder(
                          controller: _pageController,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == _programs.length) {
                              return AddProgramCard(
                                color: Colors.blueGrey,
                              );
                            } else {
                              return ProgramCard(
                                backdropKey: _backdropKey,
                                program: _programs[index],
                                color: Colors.white
                                // (
                                // id: _programs[index].color),
                                // getHeroIds: widget._generateHeroIds,
                                // getTaskCompletionPercent: model.getTaskCompletionPercent,
                                // getTotalTodos: model.getTotalTodosFrom,
                                
                              );
                            }
                          },
                          itemCount: _programs.length + 1,
                        ),

                        // return ScopedModelDescendant<WeekListModel>(builder: (BuildContext context, Widget child, WeekListModel model) {

                        // child: Consumer<TodosModel>( builder: (context, programs, child) => ProgramCards(
                        //     // color: Colors.blue,
                        //     programs: programs.allPrograms,
                        //     backdropKey: _backdropKey,
                        //   ),
                        // ),

                        // child: PageView.builder(
                        //   controller: _pageController,
                        //    itemBuilder: (BuildContext context, int index) {
                        //     print(index);

                        //   },
                        // ),

                        // child: Container(
                        //   child: Consumer<TodosModel>(
                        //     builder: (context, programs, child) {
                        //     print(programs);
                        //     return Text(programs.allPrograms.toString());
                        //     //  return ProgramCard(
                        //     //     backdropKey: _backdropKey,
                        //     //     color: ColorUtils.getColorFrom(
                        //     //     id: _programs[index].color),
                        //     //     // getHeroIds: widget._generateHeroIds,
                        //     //     // getTaskCompletionPercent: model.getTaskCompletionPercent,
                        //     //     // getTotalTodos: model.getTotalTodosFrom,
                        //     //     // program: _programs[index],
                        //     //   );
                        //   }
                        //       // => ProgramList(
                        //       // programs: programs.allPrograms,

                        //       // ),
                        //       ),
                        // ),

                        // child: PageView.builder(
                        //   controller: _pageController,
                        //   itemBuilder: (BuildContext context, int index) {
                        //     if (index == _programs.length) {
                        //       return AddPageCard(
                        //         color: Colors.blueGrey,
                        //       );
                        //     } else {
                        //       return TaskCard(
                        //         backdropKey: _backdropKey,
                        //         color: ColorUtils.getColorFrom(
                        //         id: _programs[index].color),
                        //         getHeroIds: widget._generateHeroIds,
                        //         getTaskCompletionPercent: model.getTaskCompletionPercent,
                        //         getTotalTodos: model.getTotalTodosFrom,
                        //         program: _programs[index],
                        //       );
                        //     }
                        //   },
                        //   itemCount: _programs.length + 1,
                        // ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 32.0),
                    ),
                  ],
                  // ),
                ),
        ),
      );
    });
  }
}
