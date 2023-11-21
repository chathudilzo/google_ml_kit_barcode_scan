import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit_barcode_scan/controllers/scan_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ScanController controller=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: Text('Scan Your Code',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
              ),
              Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/barcode.jpeg'),fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue,width: 3),
                  color: Color.fromARGB(255, 32, 32, 32)
                ),child: Obx((){
                  if(controller.isLoading.value){
                    return Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          
                        ),
                      ),
                    );
                  }else{
                    return Center(child: Text(controller.text.value,style: TextStyle(color: Colors.white,fontSize: 18),));
                  }
                }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                IconButton(onPressed: (){
                  controller.analizeImage('camera');
                }, icon: Icon(Icons.camera_alt,size: 55,color: Colors.blueAccent,)),
                IconButton(onPressed: (){
                  controller.analizeImage('gallery');
                }, icon: Icon(Icons.image,size: 55,color: Color.fromARGB(255, 255, 180, 68),))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}