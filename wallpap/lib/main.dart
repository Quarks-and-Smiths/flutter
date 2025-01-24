import 'dart:async';

import 'package:easy_wallpapers/easy_wallpapers.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallpap/model/mock_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: EasyWallpaperApp(
          wallpaperUrls: data,
          title: 'Wallpapers',

          leadingTitle: 'Nice',

          // bgImage:
          //     'https://i.pinimg.com/564x/99/83/87/9983876e5771924849c55d19ee7fec5a.jpg',
          placementBuilder: _addPlacements,
          onTapEvent: _onTapEvent,
          onSetOrDownloadWallpaper: _downloadWallpaper,
          isTrendingEnabled: true,
          isCacheEnabled: true,
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     EasyWallpaperApp.launchApp(
      //       context,
      //       wallpaperUrls: data,
      //       title: 'Wallpapers',
      //       bgImage:
      //           'https://i.pinimg.com/564x/99/83/87/9983876e5771924849c55d19ee7fec5a.jpg',
      //       placementBuilder: _addPlacements,
      //       onTapEvent: _onTapEvent,
      //       // onSetOrDownloadWallpaper: _downloadWallpaper,
      //     );
      //   },
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  Widget _addPlacements(BuildContext context, WallpaperPlacement placement) {
    switch (placement) {
      case WallpaperPlacement.wallpaperHomeTop:
        return Container(height: 50, width: double.infinity, color: Colors.red);
      case WallpaperPlacement.wallpaperCategoryTop:
        return Container(
            height: 50, width: double.infinity, color: Colors.orange);
    }
  }

  void _onTapEvent(BuildContext context, WallpaperEventAction eventAction) {
    printLog(eventAction.name);
  }

  StreamSubscription? _streamSubscription;

  Future<bool> _downloadWallpaper(BuildContext context) {
    final completer = Completer<bool>();

    showRewardedAdAlertDialog(
      context,
      onWatchAd: () {},
      onClickNo: () => completer.complete(true),
    );
    completer.complete(true);
    return completer.future;
  }

  void printLog(String str) {
    if (kDebugMode) {
      print(str);
    }
  }

  Future<bool?> showRewardedAdAlertDialog(BuildContext context,
      {required VoidCallback onWatchAd, required VoidCallback onClickNo}) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final no = TextButton(
          child: const Text("No"),
          onPressed: () {
            Navigator.of(context).pop(false);
            onClickNo();
          },
        );
        final yes = TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
            onWatchAd.call();
          },
          child: const Text("Download my Wallpaper"),
        );
        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          title: const Text('Download!'),
          content: const Text('Would you like to download?'),
          actions: [no, yes],
        );
        return alert;
      },
    );
  }
}
