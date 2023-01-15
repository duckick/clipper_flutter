import 'package:clipper_flutter/controller/controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


class SwitchDialog extends StatefulWidget {
  // const SwitchDialog({Key? key}) : super(key: key);

  @override
  State<SwitchDialog> createState() => _SwitchDialogState();
}




class _SwitchDialogState extends State<SwitchDialog> {


  Controller controller = Get.find<Controller>();
  var switchStorageKey = 'switchKey';
  bool vibrationSwitch = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
        value: vibrationSwitch,
        onChanged: (value) {
          setState(() {
            vibrationSwitch = value;
            print(vibrationSwitch);
          });
        });
  }
}
