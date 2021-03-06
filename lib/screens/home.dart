import 'package:flutter/material.dart';
import 'package:flutter_fitness/models/subscriber_series.dart';
import 'package:flutter_fitness/providers/subscriber_chart.dart';
import 'package:flutter_fitness/screens/program_card_add.dart';
import 'package:flutter_fitness/screens/program_card.dart';
import 'package:flutter_fitness/utils/datetime_utils.dart';
import 'package:flutter_fitness/utils/gradient_background.dart';
import 'package:provider/provider.dart';
import 'package:flutter_fitness/models/program.dart';
import 'package:flutter_fitness/models/hero_id.dart';
import 'package:flutter_fitness/providers/provider.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  HeroId _generateHeroIds(Program program) {
    return HeroId(
      // codePointId: 'code_point_id_${program.id}',
      // progressId: 'progress_id_${program.id}',
      titleId: 'title_id_${program.id}',
      // remainingTaskId: 'remaining_program_id_${program.id}',
    );
  }

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
  List<SubscriberSeries> data = [];


  List<bool> isSelected = [true, false, false, false];

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

  // void loadChart() async {
  //   data = await _db.getChartData();
  // }

  getTotal() async {
    _total = await TodosModel().getTotal();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodosModel>(builder: (context, programs, child) {
      var _programs = programs.programs;
     

      var _isLoading = false;
      var newData;
      if (isSelected[3] == true) {
        newData = programs.getYears();
      } else if (isSelected[2] == true) {
        newData = programs.getMonths();
      } else if (isSelected[1] == true) {
        newData = programs.getWeeks();
      } else if (isSelected[0] == true) {
         newData = programs.getDays();
      }
      return GradientBackground(
        color: Colors.pink,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Fitness App'),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                strokeWidth: 1.0,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          :
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
                    Container(
                      // if (isSelected[1] == true) {
                         child: SubscriberChart(data: newData)
                      // }
                     
                    ),
                    
                    // Container(padding: EdgeInsets.only(top: 0.0, bottom: 0.0),

                    ToggleButtons(
                      selectedColor: Colors.red,
                      fillColor: Colors.blue,
                      children: <Widget>[
                        Container( 
                          width: 73, 
                          padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                          alignment: Alignment.center, 
                          child: Text('Days',
                            style: TextStyle(fontSize: 12.0, color: Colors.white)
                          )
                        ),
                        Container( 
                          width: 73, 
                          padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                          alignment: Alignment.center, 
                          child: Text('Weeks',
                            style: TextStyle(fontSize: 12.0, color: Colors.white)
                          )
                        ),
                        Container( 
                          width: 73, 
                          padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                          alignment: Alignment.center, 
                          child: Text('Months',
                            style: TextStyle(fontSize: 12.0, color: Colors.white)
                          )
                        ),
                        Container( 
                          width: 73, 
                          padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                          alignment: Alignment.center, 
                          child: Text('Years',
                            style: TextStyle(fontSize: 12.0, color: Colors.white)
                          )
                        ),
                      ],
                      onPressed: (int index) {
                        setState(() {
                          for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                            if (buttonIndex == index) {
                              isSelected[buttonIndex] = true;
                            } else {
                              isSelected[buttonIndex] = false;
                            }
                          }
                        });
                      },
                      isSelected: isSelected,
                    ),

                      // child: Row(
                      //   children: <Widget>[

                      //     Container( width: 73, padding: EdgeInsets.only(top: 0.0, bottom: 0.0), child:
                      //      FlatButton(color: Colors.white,
                      //       onPressed: () async {
                      //         // setState(() {
                      //         // });
                      //       },
                      //       child: Text('Years', style: TextStyle(fontSize: 12.0))
                      //     )),
                      //     Container( width: 76, padding: EdgeInsets.only(top: 0.0, bottom: 0.0), child:
                      //      FlatButton(color: Colors.white,
                      //       onPressed: () async {
                      //         // setState(() {
                      //         // });
                      //       },
                      //       child: Text('Months', style: TextStyle(fontSize: 12.0))
                      //     )),
                      //     Container( width: 73, padding: EdgeInsets.only(top: 0.0, bottom: 0.0), child:
                      //      FlatButton(color: Colors.white,
                      //       onPressed: () async {
                      //         // setState(() {
                      //         // });
                      //       },
                      //       child: Text('Weeks', style: TextStyle(fontSize: 12.0))
                      //     )),
                      //     Container( width: 73, padding: EdgeInsets.only(top: 0.0, bottom: 0.0), child:
                      //      FlatButton(color: Colors.white,
                      //       onPressed: () async {
                      //         // setState(() {
                      //         // });
                      //       },
                      //       child: Text('Days', style: TextStyle(fontSize: 12.0))
                      //     )),
                      //   //  Expanded(flex: 1, child: Container(height: 10)),
                      //   ],
                      // ),
                      
                    // ),

                  ],
                ),
              ),
              Expanded(
                key: _backdropKey,
                flex: 1,
                child: NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification is ScrollEndNotification) {
                      var currentPage = _pageController.page.round().toInt();
                      if (_currentPageIndex != currentPage) {
                        setState(() => _currentPageIndex = currentPage);
                      }
                    }
                  },
                  child: PageView.builder(
                    controller: _pageController,
                    itemBuilder: (BuildContext context, int index) {
                      _programs.sort((a, b) => b.id.compareTo(a.id));
                      if (index == _programs.length) {
                        return AddProgramCard(
                          color: Colors.blueGrey,
                        );
                      } else {
                        return ProgramCard(
                          backdropKey: _backdropKey,
                          program: _programs[index],
                          color: Colors.white,
                          getHeroIds: widget._generateHeroIds,
                        );
                      }
                    },
                    itemCount: _programs.length + 1,
                  )
                )
              ),
              Container(
                margin: EdgeInsets.only(bottom: 32.0),
              ),
            ]
          )
        )
      );
    });
  }
}
