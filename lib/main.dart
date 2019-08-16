import 'package:flutter/material.dart';
import 'inputpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'KALEBR';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: InputPage(title: appTitle),
    );
  }
}
