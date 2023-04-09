import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mahr/view/controllers/controller.dart';
import 'package:mahr/view/subview/addpage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            body: Column(children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: Border.all(),
                      child: Container(
                        height: Get.size.height * .4,
                        width: Get.size.width * .9,
                        color: Colors.green,
                        child: Stack(
                          children:  [

                            Positioned(
                              top: 5,
                              right: 20,
                              child: Row(
                                children: [

                                  Text(" ${controller.collectTypeStrings} " ,style:  TextStyle(fontSize: 70)),
                                  Text("العيار" ,style:  TextStyle(fontSize: 70)),
                                ],
                              ),
                            ) , Positioned(
                              top: 75,
                              right: 20,
                              child: Row(
                                children: [
                                  Text(" ${controller.collectNumberStrings} " ,style:  TextStyle(fontSize: 70)),

                                  Text("العدد" ,style:  TextStyle(fontSize: 70)),
                                ],
                              ),
                            ), Positioned(
                              top: 145,
                              right: 20,
                              child: Row(
                                children: [
                                  Text(" ${controller.collectPriceStrings}  " ,style:  TextStyle(fontSize: 70)),
                                  Text("السعر الاجمالى" ,style:  TextStyle(fontSize: 70)),

                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.fatoraIncreasement,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Get.to(AddPage());
                      },
                      title: Row(
                        children: [
                          Text(" Type:    ${controller.goldType.text} "),
                          Text(" Number:  ${controller.number.text} "),
                          Text(" Price:   ${controller.price.text} ")
                        ],
                      ),
                      trailing: Image.file(controller.image),
                    );
                  },
                ),
              )
            ]),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.to(AddPage());
              },
            ),
          );
        });
  }
}
