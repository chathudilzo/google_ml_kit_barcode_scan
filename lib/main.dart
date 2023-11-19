import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit_barcode_scan/controllers/scan_controller.dart';
import 'package:google_ml_kit_barcode_scan/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(ScanController());
    
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:HomePage(),
    );
  }
}
