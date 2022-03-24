import 'package:app_thuchi/views/list_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';

import 'views/group_list_date.dart';
import 'widgets/bieudo_pie_chart.dart';
import 'widgets/home/bottom_bar_view.dart';
import 'widgets/home/fitness_app_theme.dart';
import 'widgets/home/home_item.dart';
import 'widgets/home/pro.dart';
import 'widgets/chart_bieudo.dart';
import 'widgets/home/tabIcon_data.dart';

class AppSet extends StatefulWidget {
  const AppSet({Key? key}) : super(key: key);

  @override
  _AppSetState createState() => _AppSetState();
}

class _AppSetState extends State<AppSet> {
  var theme = ValueNotifier(ThemeMode.dark);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: theme,
        builder: (context, value, child) => MaterialApp(
              title: "app",
              home: AppHomeScreen(theme: theme),
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: Colors.blue,
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                primaryColor: Colors.lightBlue[900],
              ),
              themeMode: value,
            ));
  }
}

class AppHomeScreen extends StatefulWidget {
  const AppHomeScreen({Key? key, this.theme}) : super(key: key);
  final ValueNotifier<ThemeMode>? theme;

  @override
  _AppHomeScreenState createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );
  var theme = ValueNotifier(ThemeMode.dark);
  var visible = true;
  var rmicons = false;
  var isDialOpen = ValueNotifier<bool>(false);
  var speedDialDirection = SpeedDialDirection.down; // up, down
  var selectedfABLocation = FloatingActionButtonLocation.endDocked;

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = HomeItemScreen(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        }
        return true;
      },
      // color: FitnessAppTheme.background,
      child: Container(
        color: FitnessAppTheme.background,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Thu Chi",
              style: GoogleFonts.pacifico(color: Colors.white),
            ),
            // flexibleSpace: Container(
            //   decoration: BoxDecoration(
            //       image: DecorationImage(
            //           image: AssetImage('assets/fitness_app/back.png'),
            //           fit: BoxFit.fill)),
            // ),
            actions: [
              IconButton(
                icon: const Icon(Icons.nightlight_round),
                tooltip: "Đổi nền",
                onPressed: () => {
                  widget.theme?.value = widget.theme?.value.index == 2
                      ? ThemeMode.light
                      : ThemeMode.dark
                },
              ),
              Column(
                children: [
                  Expanded(
                    child: SpeedDial(
                      icon: Icons.pageview,
                      activeIcon: Icons.close,
                      openCloseDial: isDialOpen,
                      childPadding: const EdgeInsets.all(5),
                      visible: visible,
                      direction: speedDialDirection,// view up , down
                      tooltip: 'Mở menu ',
                      elevation: 8.0,
                      children: [
                        SpeedDialChild(
                          child: !rmicons ? const Icon(Icons.search_off) : null,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          label: '',
                          onTap: () => setState(() =>
                              // rmicons = rmicons),
                              rmicons = !rmicons),
                          onLongPress: () => debugPrint(' CHILD LONG PRESS'),
                        ),
                        SpeedDialChild(
                          child: !rmicons ? const Icon(Icons.date_range_outlined) : null,
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                          label: '',
                          onTap: () => debugPrint('SECOND CHILD'),
                        ),
                        SpeedDialChild(
                          child: !rmicons ? const Icon(Icons.pageview) : null,
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          label: '',
                          visible: true,
                          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text((" Child Pressed")))),
                          onLongPress: () => debugPrint(' LONG PRESS'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 8.0,
            child: Row(
              mainAxisAlignment: selectedfABLocation ==
                      FloatingActionButtonLocation.startDocked
                  ? MainAxisAlignment.end
                  : selectedfABLocation ==
                          FloatingActionButtonLocation.endDocked
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  icon: const Icon(Icons.nightlight_round),
                  tooltip: "Đổi nền",
                  onPressed: () => {
                    widget.theme?.value = widget.theme?.value.index == 2
                        ? ThemeMode.light
                        : ThemeMode.dark
                  },
                ),
                // ValueListenableBuilder<bool>(
                //     valueListenable: isDialOpen,
                //     builder: (ctx, value, _) => IconButton(
                //           icon: const Icon(Icons.open_in_browser),
                //           tooltip: (!value ? "Mở" : "Đóng") + " Speed Dial",
                //           onPressed: () =>
                //               {isDialOpen.value = !isDialOpen.value},
                //         ))
              ],
            ),
          ),
          floatingActionButton: SpeedDial(
            icon: Icons.add,
            activeIcon: Icons.close,
            openCloseDial: isDialOpen,
            childPadding: const EdgeInsets.all(5),
            visible: visible,
            tooltip: 'Mở menu ',
            onPress: () {
              Get.to(ProductListScreen());
            },
            elevation: 8.0,
            children: [

            ],
          ),
          floatingActionButtonLocation: selectedfABLocation,
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.lightGreenAccent,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex:4,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: const Icon(Icons.close_outlined),
                            color: Colors.grey,
                            iconSize: 35,
                            tooltip: "Đóng menu",
                            onPressed: () => {
                              Navigator.pop(context)
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            image: DecorationImage(
                                // fit: BoxFit.fill,
                                image: AssetImage("assets/logo.jpg")),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Thu Chi",
                          style: GoogleFonts.pacifico(color: Colors.blue),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "amt",
                          style: GoogleFonts.lobster(),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                    onTap: () {
                      Get.to(ProductListScreen());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Row(children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(3, 10, 13, 10),
                          child: Icon(Icons.search, color: Colors.green),
                        ),
                        Text("Tìm kiếm ",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black54)),
                      ]),
                    )),
                InkWell(
                    onTap: () {
                      // _onLongPressHandler(
                      //     context, _ProductsList[index]);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Row(children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(3, 10, 13, 10),
                          child: Icon(Icons.account_tree_rounded,
                              color: Colors.orange),
                        ),
                        Text("Phân loại ",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black54)),
                      ]),
                    )),
                InkWell(
                  onTap: () {
                    // Get.to(ChartBieuDo());
                    Get.to(PieChartPage());
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(3, 10, 13, 10),
                          child: Icon(
                            Icons.pie_chart,
                            color: Colors.amber,
                          ),
                        ),
                        Text(
                          "Báo cáo",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Row(children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(3, 10, 13, 10),
                          child: Icon(Icons.next_plan, color: Colors.blue),
                        ),
                        Text("Khôi phục ban đầu",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black54)),
                      ]),
                    )),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
          body: FutureBuilder<bool>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else {
                return Stack(
                  children: <Widget>[
                    Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(child: MyHomeScreen1()),
                        ),
                        // Expanded(
                        //   flex: 4,
                        //   child: Container(child: MyHomeScreen()),
                        // ),
                        // Expanded(flex: 3, child: tabBody),
                        // Expanded(flex: 2, child: bottomBar()),
                        Expanded(
                            flex: 5,
                            child: MyList()),


                      ],
                    ),
                    Container(
                      // color: Colors.white,
                      alignment: Alignment.center,
                      child: FollowCurve2D(
                        path: path,
                        duration: const Duration(seconds: 5),
                        child: CircleAvatar(
                          backgroundColor: Colors.deepPurpleAccent,
                          child: DefaultTextStyle(
                              style: Theme.of(context).textTheme.headline6!,
                              child: Image.asset(
                                "assets/images/qb1.gif",
                              )),
                        ),
                      ),
                    ),
                    Container(
                      // color: Colors.white,
                      alignment: Alignment.center,
                      child: FollowCurve2D(
                        path: path,
                        duration: const Duration(seconds: 10),
                        child: CircleAvatar(
                          backgroundColor: Colors.deepPurpleAccent,
                          child: DefaultTextStyle(
                            style: Theme.of(context).textTheme.headline6!,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage("assets/images/q5.gif")),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  // Widget bottomBar() {
  //   return Column(
  //     children: <Widget>[
  //       const Expanded(
  //         child: SizedBox(),
  //       ),
  //       BottomBarView(
  //         tabIconsList: tabIconsList,
  //         addClick: () {
  //           Get.to(ProductListScreen());
  //           // _ChartData
  //           // Get.to(ChartBieuDo());
  //         },
  //         changeIndex: (int index) {
  //           if (index == 0 || index == 2) {
  //             animationController?.reverse().then<dynamic>((data) {
  //               if (!mounted) {
  //                 return;
  //               }
  //               setState(() {
  //                 tabBody =
  //                     HomeItemScreen(animationController: animationController);
  //               });
  //             });
  //           } else if (index == 1 || index == 3) {
  //             animationController?.reverse().then<dynamic>((data) {
  //               if (!mounted) {
  //                 return;
  //               }
  //               setState(() {
  //                 tabBody = ProductListScreen();
  //               });
  //             });
  //           }
  //         },
  //       ),
  //     ],
  //   );
  // }
}
