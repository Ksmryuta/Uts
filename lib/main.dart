import 'package:flutter/material.dart';
import 'package:notetake/inherited widget/note_inheretedwidget.dart';
import 'package:notetake/screens/note_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return NoteInheritedWidget(
      MaterialApp(
      home: NoteList(),
    ),
    );
  }
}

