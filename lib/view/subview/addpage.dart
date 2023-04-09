import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahr/view/controllers/controller.dart';
import 'package:mahr/view/home.dart';

class AddPage extends StatelessWidget {
  AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(children: [
            GestureDetector(
              onTap: () {
                controller.openImagePicker();
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Container(
                          height: Get.size.height * .4,
                          width: Get.size.width * .9,
                          color: Colors.green,
                          child: Image.file(controller.image)),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                TextField(
                    controller: controller.goldType,
                    decoration: InputDecoration(
                      labelText: "type",
                      //babel text
                      hintText: "Enter your type",
                      //hint text
                      prefixIcon: Icon(Icons.type_specimen),
                      //prefix iocn
                      hintStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      //hint text style
                      labelStyle: TextStyle(
                          fontSize: 13, color: Colors.redAccent), //label style
                    )),
                TextField(
                    keyboardType:TextInputType.number,
                    controller: controller.number,
                    decoration: InputDecoration(
                      labelText: "number",
                      //babel text
                      hintText: "Enter your number",
                      //hint text
                      prefixIcon: Icon(Icons.numbers),
                      //prefix iocn
                      hintStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      //hint text style
                      labelStyle: TextStyle(
                          fontSize: 13, color: Colors.redAccent), //label style
                    )),
                TextField(
                    keyboardType:TextInputType.number,
                    controller: controller.price,
                    decoration: InputDecoration(
                      labelText: "price",
                      //babel text
                      hintText: "Enter your price",
                      //hint text
                      prefixIcon: Icon(Icons.price_change),
                      //prefix iocn
                      hintStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      //hint text style
                      labelStyle: TextStyle(
                          fontSize: 13, color: Colors.redAccent),

                      //label style
                    )),
              ],
            ),
          ]),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(() => HomePage());
              controller.increasment();
              controller.collectType();
            },
          ),
        );
      },
    );
  }
}
