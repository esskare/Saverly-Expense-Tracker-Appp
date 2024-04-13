import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:management/Screens/home.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:management/login_page.dart';

import 'data/model/add_date.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AdddataAdapter());
  await Hive.openBox<Add_data>('data');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login_Page()
    );
  }
}
