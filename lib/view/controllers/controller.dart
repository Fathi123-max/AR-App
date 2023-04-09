import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  int fatoraIncreasement = 0;

  increasment() {
    fatoraIncreasement++;
    update();
  }

  TextEditingController goldType = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController number = TextEditingController();
  var collectTypeStrings = " ";
  var collectPriceStrings = 0;
  var collectNumberStrings = 0;

  collectType() {
    collectTypeStrings += goldType.text;
    collectPriceStrings += int.parse(price.text);
    collectNumberStrings += int.parse(number.text);
    update();
  }

  //! image
  File image = File("");

  // This is the image picker
  final picker = ImagePicker();

  // Implementing the image picker
  Future<void> openImagePicker() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      update();
    }
  }
}
