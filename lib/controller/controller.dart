import 'package:get/get.dart';


class Controller extends GetxController {

  var switchState = true.obs;  //switch value

// @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//   }

  @override
  // TODO: implement onDelete
  InternalFinalCallback<void> get onDelete => super.onDelete;
  

@override
  void dispose() {
    print('getx dispose');
    super.dispose();
  }

  @override
  void onClose() {

    super.onClose();
  }
}

