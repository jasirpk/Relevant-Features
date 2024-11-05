import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FacebookSignInC {


  static Future<UserCredential?> signWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: ['public_profile', 'email'],
      );

      if (loginResult.status == LoginStatus.success) {
        final AccessToken? accessToken = loginResult.accessToken;

        if (accessToken != null) {
          // Create a credential from the access token
          final OAuthCredential facebookAuthCredential =
              FacebookAuthProvider.credential(accessToken.tokenString);

          // Sign in to Firebase using the Facebook credential
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithCredential(facebookAuthCredential);
          User? user = userCredential.user;

          if (user != null) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('facebookMail', user.email ?? '');
            await prefs.setString('facebookName', user.displayName ?? '');
            await prefs.setString('facebookImage', user.photoURL ?? '');

            if (user.email == null) {
              print('User email is missing.');
            }
            if (user.displayName == null) {
              print('User display name is missing.');
            }
          }

          return userCredential;
        } else {
          print('Access token is null.');
        }
      } else if (loginResult.status == LoginStatus.cancelled) {
        print('Facebook sign-in was canceled by the user.');
      } else if (loginResult.status == LoginStatus.failed) {
        // Print the specific error message related to the "hash invalid" error
        print('Facebook sign-in failed: ${loginResult.message}');
      }
    } catch (e) {
      // Print the full error including stack trace for debugging
      print('Error signing in with Facebook: $e');
    }
    return null;
  }


  static Future<Map<String, String?>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('facebookName');
    String? email = prefs.getString('facebookMail');
    String? photoUrl = prefs.getString('facebookImage');

    return {
      'facebookMail': email,
      'facebookName': username,
      'facebookImage': photoUrl
    };
  }

  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('facebookMail');
    await prefs.remove('facebookName');
    await prefs.remove('facebookImage');
  }
}
