import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/controller/facebook.dart';
import 'package:flutter_demo/controller/google_auth.dart';
import 'package:flutter_demo/view/components/button.dart';
import 'package:flutter_demo/view/pages/adjust_sdk.dart';
import 'package:flutter_demo/view/pages/google_maps.dart';
import 'package:flutter_demo/view/pages/notificaiton.dart';
import 'package:flutter_demo/view/pages/payment_gateway.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? email;
  String? userName;
  String? Googleurl;
  String? facebookMail;
  String? facebookName;
  String? facebookUrl;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    Map<String, String?> userData = await GoogleSignInC.getUserData();
    setState(() {
      email = userData['email'];
      userName = userData['displayName'];
      Googleurl = userData['photoUrl'];
    });
  }

  Future<void> loadFacebookUserData() async {
    Map<String, String?> userData = await FacebookSignInC.getUserData();
    setState(() {
      facebookMail = userData['facebookEmail'];
      facebookName = userData['facebookName'];
      facebookUrl = userData['facebookImage'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Dashboard',
        ),
        actions: [
          SizedBox(
            width: 10,
          ),
          IconButton(
              onPressed: () async {
                await GoogleSignInC.clearUserData();
                await FacebookSignInC.clearUserData();
                Navigator.pop(context);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sign In credential',
                  style: TextStyle(
                      fontSize: 26,
                      color: Colors.blue,
                      fontWeight: FontWeight.w400),
                ),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      child: ListTile(
                        title: Text(email ?? '',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        leading: CircleAvatar(
                          maxRadius: 20,
                          backgroundImage:
                              (Googleurl != null && Googleurl!.isNotEmpty)
                                  ? NetworkImage(Googleurl!)
                                  : AssetImage('assets/images/flight.jpg')
                                      as ImageProvider,
                        ),
                        subtitle: Text(userName ?? ''),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'FaceBook SignIn credential',
                  style: TextStyle(
                      fontSize: 26,
                      color: Colors.blue,
                      fontWeight: FontWeight.w400),
                ),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      child: ListTile(
                        title: Text(facebookMail ?? 'jasir@tathkarah.in',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        leading: CircleAvatar(
                          maxRadius: 20,
                          backgroundImage: AssetImage(
                            'assets/images/flight.jpg',
                          ),
                        ),
                        subtitle: Text(facebookName ?? 'jasir'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ButtonWidget(
              onpressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(title: Icon(Icons.warning),
                      content: Text(
                          'Are you sure you want to check the Firebase CrashLytics? This will close your app !'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            FirebaseCrashlytics.instance.crash();
                          },
                          child: Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
              },
              text: 'CrashLytics',
            ),
            //   ButtonWidget(
            //   onpressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (ctx) => PaymentScreen(),
            //       ),
            //     );
            //   },
            //   text: 'Payment Gateway',
            // ),
            ButtonWidget(
              onpressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => AdjustSdkScreen(),
                  ),
                );
              },
              text: 'Adjust SDK',
            ),
            ButtonWidget(
              onpressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => NotificationScreen(),
                  ),
                );
              },
              text: 'Notifications',
            ),
            ButtonWidget(
              onpressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => GoogleMapsScreen(),
                  ),
                );
              },
              text: 'Google Maps',
            ),
          ],
        ),
      ),
    );
  }
}
