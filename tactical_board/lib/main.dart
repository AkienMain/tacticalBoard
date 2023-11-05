import 'package:flutter/material.dart';
import 'package:tactical_board/board_page.dart';
import 'package:tactical_board/parts_widget.dart';

void main() => runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    );

class TabInfo {
  String label;
  Widget widget;
  TabInfo(this.label, this.widget);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    StaticVars.windowSize = MediaQuery.of(context).size;
    StaticVars.setStaticVars();
    return const BoardPage(
      title: 'Board',
    );
  }
}
