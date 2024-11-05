import 'package:flutter/material.dart';
import 'package:flutter_demo/controller/adjust.dart';
import 'package:flutter_demo/view/components/button.dart';

class AdjustSdkScreen extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<AdjustSdkScreen> with WidgetsBindingObserver {
  bool isLook=false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      AdjustService.onResume(); // Track session when app is resumed
    } else if (state == AppLifecycleState.paused) {
      AdjustService.onPause(); // Track session pause when app is paused
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Adjust SDK Example'),
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Card(
                  child: ButtonWidget(
                          onpressed: () {
                          setState(() {
                              isLook=!isLook;
                          });
                  AdjustService.trackEvent('2dmq9ivpnji8');
                          },
                          text: 'Track Event',
                        ),
                ),
              ),
              isLook==true?Text('Track your Events!\nPlease check your Console!',textAlign: TextAlign.center,):Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Press Button'),
                  Icon(Icons.arrow_outward_sharp)
                ],
              ),
            ],
          )),
    );
  }
}
