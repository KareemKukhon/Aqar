import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MylocalController extends GetxController {

  void changeLang (String codelang){
    Locale locale = Locale(codelang);
    Get.updateLocale(locale);

  }
}