import 'package:firebase_auth/firebase_auth.dart';

class Users {
  Users();
  String getID() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  String getUserName() {
    return FirebaseAuth.instance.currentUser!.displayName!;
  }

  String getUserEmail() {
    return FirebaseAuth.instance.currentUser!.email!;
  }
}
