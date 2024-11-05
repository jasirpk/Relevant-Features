import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleSignInC {
  static Future<UserCredential?> signWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // User canceled the sign-in process
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Get the signed-in user
      User? user = userCredential.user;
      if (user != null) {
        // Store user data in shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', user.email ?? '');
        await prefs.setString('displayName', user.displayName ?? '');
        await prefs.setString('photoUrl', user.photoURL ?? '');
      }

      return userCredential;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  // Function to retrieve user data from SharedPreferences
  static Future<Map<String, String?>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('displayName');
    String? email = prefs.getString('email');
    String? photoUrl = prefs.getString('photoUrl');

    return {'email': email, 'displayName': username, 'photoUrl': photoUrl};
  }

  // Function to clear user data from SharedPreferences (for sign-out)
  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('displayName');
    await prefs.remove('email');
    await prefs.remove('photoUrl');
  }
}
