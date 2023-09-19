

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controllers/coin_controller%20copy.dart';
import 'package:myapp/views/home/home.dart';


void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( 
      debugShowCheckedModeBanner: false,
      home:RefactoredHomeScreen(),
    );
  }
}