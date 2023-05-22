

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../models/user.dart';

class UserProvider with ChangeNotifier {
  Users? _user;
  Users get getUser => _user!;

  Future<void> refreshUser() async {
    Users? user = await AuthMethod().getUserDetails();
    _user = user;
    notifyListeners();
  }
 
}

class AuthMethod {
  Future<Users?> getUserDetails() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser.uid)
          .get();
      if (documentSnapshot.exists) {
        return Users.fromSnap(documentSnapshot);
      }
    }
    return null; 
  }
}