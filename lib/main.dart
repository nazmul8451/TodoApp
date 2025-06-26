
import 'package:calculator/WaterTracker_Project.dart';
import 'package:calculator/calculator_project.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Todo_project.dart';

//All Package imported


void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MaterialApp(
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        home:TodoApp() ,
      ), // runApp এর ভিতরে DevicePreview
    ),
  );
}
