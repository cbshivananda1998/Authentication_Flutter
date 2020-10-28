

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class AuthenticationMethods{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool isUserSignedIn = false;
  User signedInUser;

void getCurrentUser() async {
    signedInUser = await _auth.currentUser;
    print("Current User : $signedInUser" );
  }
  
  void signUpWithEmail(String email,String password) async{
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (newUser != null) {
        print("Sign up successful");
      }
    } catch (e) {
      print(e);
      print("Sign up unsuccessful");
    }
  }

  Future<bool> signInWithEmail(String email,String password) async{
    try {
     var userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
     if(userCredential==null){
       return false;
     }
     else{
       return true;
     }
    } catch (e) {
      print(e);
      return false;
    }
  }
  
  Future<bool> signOut() async {
    try{
       await _auth.signOut();
      print("Sign Out successful");
      return true ;
    }
    catch(e){
      print("Sign Out Unsuccessful");
      return false;
    }

  }
  
  Future<bool> signInWithGoogle() async {
    try{
      GoogleSignInAccount account=  await _googleSignIn.signIn();
      if(account==null){
        return false ;
      }
      _auth.signInWithCredential(GoogleAuthProvider.credential(idToken: (await account.authentication).idToken,
          accessToken: (await account.authentication).accessToken));
      return true ;
    }
    catch(e){
      print(e);
      return false ;
    }
  }
  
}