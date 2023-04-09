import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Store extends StatelessWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Card(
            child: Container(
              child: Stack(
                children: [
                  Positioned(
                    child: Text("data"),
                    top: 20,
                    right: Get.width * .4,
                  )
                ],
              ),
              height: Get.size.height * .9,
              width: Get.size.width * .95,
              color: Colors.green,
            ),
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}
