import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Types extends StatelessWidget {
  const Types({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Card(
          child: SafeArea(
            child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => PageView());
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: Card(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Container(
                                child: Stack(
                                  children: [
                                    Positioned(
                                      child: const Text("data"),
                                      top: 5,
                                      right: Get.height * .1,
                                    )
                                  ],
                                ),
                                height: Get.size.height * .20,
                                width: Get.size.width * .4,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Container(
                                child: Stack(
                                  children: [
                                    Positioned(
                                      child: const Text("data"),
                                      top: 5,
                                      right: Get.height * .1,
                                    )
                                  ],
                                ),
                                height: Get.size.height * .20,
                                width: Get.size.width * .4,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
