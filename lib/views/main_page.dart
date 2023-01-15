import 'package:clipper_flutter/controller/controller.dart';
import 'package:clipper_flutter/views/pages/page_four.dart';
import 'package:clipper_flutter/views/pages/page_one.dart';
import 'package:clipper_flutter/views/pages/page_three.dart';
import 'package:clipper_flutter/views/pages/page_two.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io' show Platform;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';





//--------------------------------------------------

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => MainPageState();

}



class MainPageState extends State<MainPage> with WidgetsBindingObserver{

  Controller controller = Get.put(Controller() );
   bool vibrationSwitch = true; //vibration switch viewmodel


  getSwitchState() async{
    final prefs = await SharedPreferences.getInstance();
    bool? switchState = prefs.getBool('switchKey');
    if (switchState == null) {
      vibrationSwitch = true;
    } else {
      vibrationSwitch = switchState;
    }
  }



  // App Killing (WidgetsBinidng)
  @override
  void initState() {
    getSwitchState();
    controller.switchState.value = vibrationSwitch;
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // App Killing (WidgetsBinidng)
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   switch (state) {
  //     case AppLifecycleState.resumed:
  //       setState(() {
  //         _text = 'Resumed!';
  //       });
  //       print('resumed');
  //       break;
  //     case AppLifecycleState.inactive:
  //       print('inactive');
  //       break;
  //     case AppLifecycleState.detached:
  //       print('detached');
  //       // DO SOMETHING!
  //       break;
  //     case AppLifecycleState.paused:
  //       print('paused');
  //       break;
  //     default:
  //       break;
  //   }

    //홈버튼,뒤로가기 눌러도 작동 안함
  // @override
  // void dispose() {
  //   print('main_page dispose--');
  //   super.dispose();
  // }


  @override
  Widget build(BuildContext context) {

    final PageController pageController = PageController();
    final PageScrollPhysics pageScrollPhysics  = PageScrollPhysics();

    return SafeArea(
      child: Stack(
            children: [

              Container(
                // height: MediaQuery.of(context).size.height * 0.96,
                child: PageView(
                  pageSnapping: true,
                  physics: pageScrollPhysics,
                  controller: pageController,
                  children: [
                    Center( child: PageOne() ),
                    Center( child: PageTwo() ),
                    Center( child: PageThree() ),
                    // Center( child:  PageFour() )
                  ],
                ),
              ),

              Positioned.fill(
                bottom: 10,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SmoothPageIndicator(
                                  controller: pageController,
                                  count: 3,
                                  effect: WormEffect(
                                    activeDotColor: Colors.lightBlue
                                  ),
                                ),
                              ]
                          ),
                      ),
                    ],
              )
             ),


              Positioned.fill(
                top: 10,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child:
                              GestureDetector(
                                child: Switch(
                                    value: vibrationSwitch,
                                    onChanged: (value) async{
                                      final prefs = await SharedPreferences.getInstance();

                                      setState(() {
                                        vibrationSwitch = value;
                                        prefs.setBool('switchKey',vibrationSwitch);

                                        print("MainPage Switch State @@  ${vibrationSwitch}");
                                        controller.switchState.value = vibrationSwitch;

                                        Get.snackbar('VIBRATION','message',
                                            icon: Icon(Icons.vibration),
                                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                                            margin: EdgeInsets.only(bottom: 10),
                                        duration: Duration(milliseconds: 900),
                                        snackPosition: SnackPosition.BOTTOM,
                                          // titleText: Container(child: Text('title text'),),
                                          messageText: Container(
                                            child: Text( vibrationSwitch ? 'ON' : 'OFF'),
                                          )
                                        );
                                      });
                                    }

                                ),

                                // onTap: () {
                                //   Get.dialog(
                                //     Dialog(
                                //       child: Container(
                                //         width: 100, height: 110,
                                //         child: Center(
                                //             child: Column(
                                //               children: [
                                //                 Padding(
                                //                   padding: const EdgeInsets.only(top: 14,bottom: 8),
                                //                   child: Icon(Icons.vibration),
                                //                 ),
                                //                 SwitchDialog(),
                                //
                                //                 Switch(
                                //                   activeColor: Colors.lightBlue,
                                //                   value: vibrationSwitch,
                                //                   onChanged: (value) {
                                //                     setState(() {
                                //                       vibrationSwitch = value;
                                //                       print(vibrationSwitch);
                                //                     });
                                //                   },
                                //                 ),
                                //
                                //
                                //               ],
                                //             ),
                                //         ),
                                //       ),
                                //     )
                                //   );
                                // },
                                // child: Icon(Icons.settings)
                              ),
                    )
                    // Icon(Icons.settings),
                  ),
                ),
            ]
          ),
    );
  }
}


