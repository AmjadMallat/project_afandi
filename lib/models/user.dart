import 'package:cloud_firestore/cloud_firestore.dart';

//heda class user ta 7ta a3mlo add bl firebase w e2dr 3abi l information tb3ono 


class Users {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String uid;
  final List<String> favorites;


  Users({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.uid,
    required this.favorites,
    required this.phoneNumber,

  });

  Map<String, dynamic> toJson() => {
        "First name": firstName,
        "Last name": lastName,
        "Email": email,
        "uid": uid,
        "favorites": favorites,

        "phoneNumber": phoneNumber,



      };

  static Users fromJson(Map<String, dynamic> map) => Users(
        firstName: map["First name"],
        lastName: map["Last name"],
        email: map["Email"],
        uid: map["uid"],
        favorites: map["favorites"],
        phoneNumber: map["phoneNumber"],


      );

  static Users fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    // List<String> newPost=List<String>.from(snapshot["posts"]);
    List<String> favorites = List<String>.from(snapshot["favorites"]);
List<String> addFriends = List<String>.from(snapshot["addFriends"]);
    return Users(
      firstName: snapshot["First name"],
      lastName: snapshot["Last name"],
      email: snapshot["Email"],
      uid: snapshot["uid"],
      favorites: favorites,
      phoneNumber: snapshot["phoneNumber"],


    );
  }
}
