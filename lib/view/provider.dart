import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahr/view/subview/page.dart';

class Providers extends StatelessWidget {
  const Providers({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Card(
          child: SafeArea(
            child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  child: Card(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                              child: InkWell(
                                  onTap: () => Get.to(ww()),
                                  child: Container(
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          child: Text("data"),
                                          top: 5,
                                          right: Get.height * .1,
                                        )
                                      ],
                                    ),
                                    height: Get.size.height * .20,
                                    width: Get.size.width * .4,
                                    color: Colors.green,
                                  ))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: InkWell(
                              onTap: () => Get.to(ww()),
                              child: Container(
                                child: Stack(
                                  children: [
                                    Positioned(
                                      child: Text("data"),
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
                        ),
                      ],
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
