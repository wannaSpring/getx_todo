import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:todo/screens/HomeScreen.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  // Mounted material ui
  runApp(GetMaterialApp(
    home: HomeScreen(),
  ));
}
