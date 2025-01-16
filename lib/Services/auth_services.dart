import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
//   SignIn with email and password..
  Future AccountwithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return 'Account Created';
    } catch (e) {
      print(e.toString());
    }
  }

// login with email and password..

  Future LogInwithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return 'Login Done';
    } catch (e) {
      print(e.toString());
    }
  }
  // logout

  Future LogOut(String email, String password) async {
    await FirebaseAuth.instance.signOut();
  }

  // sign in or not
  Future isLoggedIn() async {
    var User = FirebaseAuth.instance.currentUser;
    try {
      if (User == null) {}
    } catch (e) {
      print(e.toString());
    }
  }
  final auth = FirebaseAuth.instance;
  final googleSignInDevices = GoogleSignIn( );

  Future<User?>signUpwithGoogle()async{
    try{
      final GoogleSignInAccount? googleUser = await googleSignInDevices.signIn();
      if(googleUser == null){
        return null;}
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
      );
      final userCredential = await auth.signInWithCredential(credential);
      return userCredential.user;

    }catch(e){
      print(e.toString());
      return null;}}
}
