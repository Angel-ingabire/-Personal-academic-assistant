import 'package:flutter/material.dart';
import 'screens/assignments_screens.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ALU Assistant',
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF0A192F),
        scaffoldBackgroundColor: const Color(0xFF0A192F),
      ),
      home: AssignmentsScreen(),
    );
  }
}
