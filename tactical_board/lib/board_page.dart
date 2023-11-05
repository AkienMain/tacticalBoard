import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tactical_board/parts_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({super.key, required this.title});
  final String title;
  @override
  State<BoardPage> createState() => BoardPageState();
}

class BoardPageState extends State<BoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            alignment: const Alignment(0, -0.7),
            child: const Text('Tactical Board',
                style: TextStyle(
                    color: Colors.black12,
                    fontSize: 36,
                    fontWeight: FontWeight.w900)),
          ),
          for (int team = 0; team < StaticVars.playerNums.length; team++) ...{
            for (int player = 0;
                player < StaticVars.playerNums[team];
                player++) ...{
              markerPositioned(StaticVars.markers[team][player],
                  StaticVars.colors[team], 32, 18),
            }
          },
          ballPositioned(StaticVars.ball, Colors.indigo, 24)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, StateSetter setState) {
                  return AlertDialog(
                    backgroundColor: Colors.white.withOpacity(0.8),
                    title: const Text('Settings'),
                    content: SizedBox(
                      width: 300,
                      height: 400,
                      child: Center(
                        child: Column(children: [
                          for (int team = 0;
                              team < StaticVars.playerNums.length;
                              team++) ...{
                            PartsWidget.textContainer(
                                'Team$team Players', 24, 4),
                            PartsWidget.textContainer(
                                StaticVars.playerNums[team].toString(), 48, 4),
                            Container(
                              width: StaticVars.windowSize.width * 0.8,
                              margin: const EdgeInsets.all(4),
                              child: Slider(
                                value: StaticVars.playerNums[team].toDouble(),
                                onChanged: (double value) {
                                  StaticVars.playerNums[team] = value.round();
                                  setState(() {});
                                  setStatePage();
                                },
                                min: StaticVars.minPlayerNum.toDouble(),
                                max: StaticVars.maxPlayerNum.toDouble(),
                                activeColor: StaticVars.colors[team],
                                inactiveColor: Colors.black12,
                              ),
                            ),
                          },
                          TextButton(
                            onPressed: () {
                              launchUrl(Uri.parse(
                                  'https://akien.jimdofree.com/privacy-policy/'));
                            },
                            child: const Text('Privacy Policy'),
                          ),
                          FutureBuilder<PackageInfo>(
                            future: PackageInfo.fromPlatform(),
                            builder: (BuildContext context,
                                AsyncSnapshot<PackageInfo> snapshot) {
                              if (snapshot.hasError) {
                                return const Text('ERROR');
                              } else if (!snapshot.hasData) {
                                return const Text('Loading...');
                              }

                              final data = snapshot.data!;

                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text('Version: ${data.version}')],
                              );
                            },
                          ),
                        ]),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.settings),
      ),
    );
  }

  markerPositioned(
      Marker marker, Color markerColor, double dia, double fontSize) {
    return Positioned(
      left: marker.pos.dx - dia,
      top: marker.pos.dy - dia,
      child: Draggable(
        feedback: PartsWidget.markerContainer(marker.number.toString(),
            Colors.grey, dia, fontSize), // Dragging State
        childWhenDragging: Container(), // Disappear Marker Which Before Drag
        onDraggableCanceled: (_, offset) {
          marker.pos = Offset(offset.dx + dia, offset.dy + dia);
          setState(() {});
        }, // Update Marker Position
        child: PartsWidget.markerContainer(marker.number.toString(),
            markerColor, dia, fontSize), // Placement State
      ),
    );
  }

  ballPositioned(Ball ball, Color ballColor, double dia) {
    return Positioned(
      left: ball.pos.dx - dia,
      top: ball.pos.dy - dia,
      child: Draggable(
        feedback: PartsWidget.ballContainer(Colors.grey, dia), // Dragging State
        childWhenDragging: Container(), // Disappear Marker Which Before Drag
        onDraggableCanceled: (_, offset) {
          ball.pos = Offset(offset.dx + dia, offset.dy + dia);
          setState(() {});
        }, // Update Marker Position
        child: PartsWidget.ballContainer(ballColor, dia), // Placement State
      ),
    );
  }

  setStatePage() {
    setState(() {});
  }
}
