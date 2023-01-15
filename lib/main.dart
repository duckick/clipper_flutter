import 'package:clipper_flutter/views/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

AppOpenAd? openAd;

Future<void> loadAd() async {
  await AppOpenAd.load(
      adUnitId: 'ca-app-pub-9826145572344148/6950957160',

      //testId: 'ca-app-pub-3940256099942544/3419835294'
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad){
            print('ad is loaded');
            openAd = ad;
            openAd!.show();
          },
          onAdFailedToLoad: (error) {
            print('ad failed to load $error');
          }), orientation: AppOpenAd.orientationPortrait
  );
}

void showAd() {
  if(openAd == null) {
    print('trying tto show before loading');
    loadAd();
    return;
  }

  openAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        print('onAdShowedFullScreenContent');
      },
      onAdFailedToShowFullScreenContent: (ad, error){
        ad.dispose();
        print('failed to load $error');
        openAd = null;
        loadAd();
      },
      onAdDismissedFullScreenContent: (ad){
        ad.dispose();
        print('dismissed');
        openAd = null;
        loadAd();
      }
  );

  openAd!.show();
}


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  await loadAd();
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.lightBlue[300]
    ));


    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // useMaterial3: true,
        primarySwatch: Colors.lightBlue,
      ),
      home: Scaffold(
          body: MainPage(
        ),
      ),
    );
  }
}

