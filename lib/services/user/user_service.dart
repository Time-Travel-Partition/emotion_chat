import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> updateUserName(name) async {
    final User currentUser = _auth.currentUser!;

    await currentUser.updateDisplayName(name);
    await _firestore
        .collection("Users")
        .doc(currentUser.uid)
        .update({'name': name});
  }
}
