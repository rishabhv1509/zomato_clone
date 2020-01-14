import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zomato_clone/services/base_auth.dart';

class AuthenticationService extends BaseAuth {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _auth.currentUser();
    return user;
  }

  @override
  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _auth.currentUser();
    return user.isEmailVerified;
  }

  @override
  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _auth.currentUser();
    user.sendEmailVerification();
  }

  @override
  Future<String> signIn(String userName, String password) async {
    try {
      print(password);
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: userName, password: password);
      FirebaseUser user = result.user;
      return user.uid;
    } catch (error) {
      return error.toString();
    }
  }

  @override
  Future<void> signOut() {
    return _auth.signOut();
  }

  @override
  Future<String> signUp(String email, String password) async {
    final CollectionReference usersCollection =
        Firestore.instance.collection('Users');
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      print(user.uid);
      await usersCollection.document(user.uid).setData({
        'first_name': 'Hello',
        'last_name': 'world',
        'password': password,
        'email_id': email
      });
      return user.uid;
    } catch (error) {
      print(error.toString());
      return error.toString();
    }
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Sign Out");
  }
}
