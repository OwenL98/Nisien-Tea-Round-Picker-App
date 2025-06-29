import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nisien_tea_round_picker_app/common/http_override.dart';
import 'package:nisien_tea_round_picker_app/routing/navigation_bar.dart';

void main() {
  //Enables localhost to be hit from emulator
  HttpOverrides.global = HttpOverride();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nisien Tea Round Picker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const NavBar(),
    );
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Nisien Tea Round Picker')),
    body: Center(),
  );
}
