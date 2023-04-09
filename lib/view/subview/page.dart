import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ww extends StatelessWidget {
  const ww({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        GestureDetector(
          onTap: () {
            Get.snackbar("title", "message", snackPosition: SnackPosition.TOP);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Container(
                    child: Stack(
                      children: [
                        Positioned(
                          child: Text("data"),
                          top: 5,
                          right: Get.width * .4,
                        )
                      ],
                    ),
                    height: Get.size.height * .4,
                    width: Get.size.width * .9,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return TextFormField();
            },
          ),
        )
      ]),
    );
  }
}
