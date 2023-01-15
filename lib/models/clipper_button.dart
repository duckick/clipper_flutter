import 'package:clipper_flutter/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClipperButton extends StatelessWidget {
  // const ClipperButton({Key? key}) : super(key: key);
  Controller controller = Get.find<Controller>();

  final String title;
  void Function() onPressed;


  ClipperButton({
    required this.title,
    required this.onPressed
});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),


          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            elevation: 0,
            padding: EdgeInsets.all(30),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.0) )
          ),
        );
  }
}
