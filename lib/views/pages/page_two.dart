import 'package:clipper_flutter/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:clipper_flutter/views/main_page.dart';
import 'package:vibration/vibration.dart';



class PageTwo extends StatefulWidget {
  // const PageTwo({Key? key}) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}
/////////////////////////////////////////////////////////////


class _PageTwoState extends State<PageTwo> with SingleTickerProviderStateMixin, WidgetsBindingObserver{

  Controller controller = Get.find<Controller>();
  late AnimationController aniController = AnimationController(
      vsync: this, duration: Duration(milliseconds: 200)
  );


  AudioPlayer player = AudioPlayer();
  bool _trigger = true;
  bool _auidoPlay = true;

  // var mainPageState = MainPageState();
  // var switchState = mainPageState.vibrationSwitch;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        Container(

          width:MediaQuery.of(context).size.width ,
          height: MediaQuery.of(context).size.height * 0.9,

          // width: 10, height: 10,     //test,
          child: GestureDetector(
              onTap: () {
                print("controller value ${controller.switchState}");
                //vibration
                if (controller.switchState == true) {
                  if (_trigger) {
                    Vibration.vibrate(duration: 30000, repeat: -1  );
                  } else { Vibration.cancel(); }
                } else {
                  //굳이 쓸거 없음.
                }

                setState(() {
                  if (_trigger) {
                    player.play(AssetSource('audios/clipper2.mp3'));
                  } else {
                    player.stop();
                  }
                  _trigger = !_trigger;
                  // _auidoPlay = !_auidoPlay;
                });
              },

              child:
              AnimatedContainer(
                  width: 200, height: 200,
                  duration: Duration(seconds: 1),
                  child: Image.asset('assets/images/clipper.png',
                    color: _trigger ? Colors.black : Colors.green,
                  )
              )
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    player.setSourceAsset('audios/clipper2.mp3');
  }

  @override
  void dispose() {
    player.stop();
    Vibration.cancel();
    print('page_Two dispose ');
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        setState(() {
          var _text = 'Resumed!';
        });
        print('resumed');
        break;
      case AppLifecycleState.inactive:
        print('inactive');
        break;
      case AppLifecycleState.detached:
        print('detached');
        ///////////detached
        player.stop();
        Vibration.cancel();
        print('Detached');
        break;
      case AppLifecycleState.paused:
        print('paused');
        player.stop();
        Vibration.cancel();
        break;
      default:
        break;
    }
  }

  void handleOnPressed() {
    setState(() {
      _trigger = !_trigger;
      _trigger ? aniController.forward() : aniController.reverse();
    });
  }
}
