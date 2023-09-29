import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progressive_overload/components/blurred_button.dart';
import 'package:progressive_overload/components/text_style.dart';
import 'package:progressive_overload/pages/new_workout.dart';
import 'package:progressive_overload/pages/view_workouts.dart';
import 'package:progressive_overload/theme/dark_theme.dart';
import 'package:progressive_overload/util/box_manager.dart';
import 'package:progressive_overload/util/device_specific.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
    required this.boxManager,
  });

  final BoxManager boxManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      // body: oldMenu(boxManager: boxManager),
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 42),
            child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Home",
                  style: Font(color: Colors.black, size: 30, bold: true),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 32.0, top: 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Good morning Aevin",
                style: Font(color: Colors.grey[600]!, bold: true, size: 20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recent workouts",
                style: Font(bold: true, color: Colors.black, size: 22),
              ),
            ),
          ),
          const SingleChildScrollView(
              clipBehavior: Clip.antiAlias,
              padding: EdgeInsets.only(bottom: 10, right: 16),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  RecentWorkoutCard(),
                  RecentWorkoutCard(),
                  RecentWorkoutCard(),
                ],
              )),
          const LineChartSample1()
        ]),
      ),
    );
  }
}

class LineChartSample1 extends StatefulWidget {
  const LineChartSample1({super.key});

  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue[700]!,
                Colors.deepPurpleAccent[400]!,
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            // boxShadow: const [
            //     BoxShadow(
            //         color: Colors.black,
            //         offset: Offset(2, 2),
            //         blurRadius: 5,
            //         spreadRadius: 2)
            //   ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(left: 56, top: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Monthly Workouts',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16, left: 6),
                        child: Transform.scale(
                            scale: 0.75,
                            child:
                                _LineChart(isShowingMainData: isShowingMainData)),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
                  ),
                  onPressed: () {
                    setState(() {
                      isShowingMainData = !isShowingMainData;
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LineChart extends StatelessWidget {
  const _LineChart({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      isShowingMainData ? sampleData1 : sampleData2,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 14,
        maxY: 4,
        minY: 0,
      );

  LineChartData get sampleData2 => LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData,
        titlesData: titlesData2,
        borderData: borderData,
        lineBarsData: lineBarsData2,
        minX: 0,
        maxX: 14,
        maxY: 6,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
        lineChartBarData1_3,
      ];

  LineTouchData get lineTouchData2 => const LineTouchData(
        enabled: false,
      );

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData2 => [
        lineChartBarData2_1,
        lineChartBarData2_2,
        lineChartBarData2_3,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1m';
        break;
      case 2:
        text = '2m';
        break;
      case 3:
        text = '3m';
        break;
      case 4:
        text = '5m';
        break;
      case 5:
        text = '6m';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('SEPT', style: style);
        break;
      case 7:
        text = const Text('OCT', style: style);
        break;
      case 12:
        text = const Text('DEC', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom:
              BorderSide(color: AppColors.primary.withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: AppColors.contentColorGreen,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 1.5),
          FlSpot(5, 1.4),
          FlSpot(7, 3.4),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        color: AppColors.contentColorPink,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: AppColors.contentColorPink.withOpacity(0),
        ),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
      );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
        isCurved: true,
        color: AppColors.contentColorCyan,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 2.8),
          FlSpot(3, 1.9),
          FlSpot(6, 3),
          FlSpot(10, 1.3),
          FlSpot(13, 2.5),
        ],
      );

  LineChartBarData get lineChartBarData2_1 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: AppColors.contentColorGreen.withOpacity(0.5),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 4),
          FlSpot(5, 1.8),
          FlSpot(7, 5),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
      );

  LineChartBarData get lineChartBarData2_2 => LineChartBarData(
        isCurved: true,
        color: AppColors.contentColorPink.withOpacity(0.5),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          color: AppColors.contentColorPink.withOpacity(0.2),
        ),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
      );

  LineChartBarData get lineChartBarData2_3 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: AppColors.contentColorCyan.withOpacity(0.5),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 3.8),
          FlSpot(3, 1.9),
          FlSpot(6, 5),
          FlSpot(10, 3.3),
          FlSpot(13, 4.5),
        ],
      );
}

class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}

class RecentWorkoutCard extends StatelessWidget {
  const RecentWorkoutCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: widthOfCurrentDevice(context) * 0.5, // Set the width
          height: widthOfCurrentDevice(context) * 0.5, // Set the height
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.blue[700]!,
                Colors.deepPurpleAccent[400]!,
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
              // color: Colors.deepPurpleAccent, // Transparent background color
              borderRadius:
                  BorderRadius.circular(16.0), // Optional: Add rounded corners
              // boxShadow: const [
              //   BoxShadow(
              //       color: Colors.black,
              //       offset: Offset(2, 2),
              //       blurRadius: 5,
              //       spreadRadius: 2)
              // ]
              ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 10, right: 10, bottom: 20),
                child: Column(children: [
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.arrowtriangle_right_fill,
                        color: Colors.white,
                        size: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: SizedBox(
                          width: 124,
                          child: Text(
                            "Start New Workout 1",
                            overflow: TextOverflow.fade,
                            style: Font(size: 18, bold: true),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "Et aute in veniam ea sit. Occaecat exercitation elit eiusmod irure.",
                      style: Font(
                          color: const Color.fromARGB(255, 167, 166, 166),
                          size: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        const Icon(
                          CupertinoIcons.chart_bar_circle,
                          color: Colors.white,
                          size: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            "121 Kcal - 72 mins",
                            style: Font(
                                color: const Color.fromARGB(255, 167, 166, 166),
                                size: 15),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            ),
          ),
        ),
      ),

      // BlurryButton(
      //     width: widthOfCurrentDevice(context) * 0.5,
      //     height: widthOfCurrentDevice(context) * 0.5,
      //     color: Colors.deepPurpleAccent,
      //     onPressed: () {},
      //     child: Column(children: [
      //       Text(
      //         "Start New Workout 1",
      //         style: Font(size: 18, bold: true),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.only(top: 10),
      //         child: Text("Et aute in veniam ea sit. Occaecat exercitation elit eiusmod irure.", style: Font(color: Color.fromARGB(255, 37, 37, 37), size: 14),),
      //       )
      //     ])),
    );
  }
}

class oldMenu extends StatelessWidget {
  const oldMenu({
    super.key,
    required this.boxManager,
  });

  final BoxManager boxManager;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        BlurryButton(
          color: Colors.deepPurpleAccent,
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => const ViewWorkoutsPage()),
            );
          },
          width: widthOfCurrentDevice(context) * 0.8,
          height: heightOfCurrentDevice(context) * 0.175,
          child: Text(
            "View Workouts",
            style: Font(),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        BlurryButton(
          color: Colors.deepPurpleAccent,
          onPressed: () {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => const NewWorkout()));
          },
          width: widthOfCurrentDevice(context) * 0.8,
          height: heightOfCurrentDevice(context) * 0.175,
          child: Text(
            "New workout",
            style: Font(),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        BlurryButton(
          color: Colors.deepPurpleAccent,
          onPressed: () async {
            await boxManager.clearBox();
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Deleted all workouts',
                  style: Font(size: 16),
                ),
                duration: const Duration(milliseconds: 1275),
                showCloseIcon: true,
                closeIconColor: Colors.red,
              ),
            );
          },
          width: widthOfCurrentDevice(context) * 0.8,
          height: heightOfCurrentDevice(context) * 0.175,
          child: Text(
            "Delete all workouts",
            style: Font(),
            textAlign: TextAlign.center,
          ),
        ),
      ]),
    );
  }
}
