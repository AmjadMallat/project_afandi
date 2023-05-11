import 'package:cloud_firestore/cloud_firestore.dart';

//heda class ll post la 7ta e2dr oslo bl firebase w bs a3ml add post etlob hl class


class Post {
  final String title;
  final String price;
  final String description;
  final String image;

  Post({
    required this.title,
    required this.price,
    required this.description,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "description": description,
        "image": image,
      };

  static Post fromJson(Map<String, dynamic> map) => Post(
        title: map["title"],
        price: map["price"],
        description: map["description"],
        image: map["image"],
      );

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    // List<String> newPost=List<String>.from(snapshot["posts"]);
    return Post(
      title: snapshot["title"],
      price: snapshot["price"],
      description: snapshot["description"],
      image: snapshot["image"],
    );
  }
}
