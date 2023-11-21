

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanController extends GetxController{

RxBool isLoading=false.obs;
RxString text=''.obs;


Future<void> analizeImage(String option)async{
  final barcodeScanner=GoogleMlKit.vision.barcodeScanner();
  try{
    
    text.value='';
    isLoading.value=true;
    final ImagePicker picker=ImagePicker();

    var file;

    if(option=='camera'){
      file=await picker.pickImage(source: ImageSource.camera);
    }else{
      file=await picker.pickImage(source: ImageSource.gallery);
    }

    final visionImage=InputImage.fromFilePath(file!.path);

    var barcodeText=await barcodeScanner.processImage(visionImage);
    print(barcodeText);
    for(Barcode barcode in barcodeText){
      text.value+='Barcode: ${barcode.displayValue}\n';
    }
    print('VALUE '+text.value);
    for (Barcode barcode in barcodeText){
      switch(barcode.type){
        case BarcodeType.url:
          handleUrlBarcode(barcode.value as BarcodeUrl);
          print(barcode.value);
          break;
        case BarcodeType.wifi:
          handleWifiBarcode(barcode.value as BarcodeWifi);
          break;
        default:
          break;  
      } 
    }
    isLoading.value=false;
   barcodeScanner.close(); 
  }catch(error){
    print('ERROR'+error.toString());
    text.value=error.toString();
    isLoading.value=false;
    
  }
  barcodeScanner.close();
}


void handleUrlBarcode(BarcodeUrl barcodeUrl)async{
  final Uri url=Uri.parse(barcodeUrl.url!);

  if(await canLaunchUrl(url)){
    await launchUrl(url);
    
  }else{
    Get.snackbar('Error', 'Unsupported Url');
   
  }
   isLoading.value=false;
    
}

void handleWifiBarcode(BarcodeWifi barcodeWifi)async{
  String ssid=barcodeWifi.ssid.toString();
  String password = barcodeWifi.password.toString();
  
  print('Connecting to WiFi SSID: $ssid, Password: $password');
  
}

void connectToWifi(String ssid,String password){

}

}