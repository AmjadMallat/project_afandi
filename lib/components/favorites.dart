import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_hekmat/models/post.dart';
import 'package:senior_hekmat/models/user.dart';

import '../auth_page.dart/provider/provider.dart';
import '../home/postCard.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  late final Post post;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getPost();
  }

  List<Post> list = [];

//to add a new post
  Future<void> getPost() async {
    List favorites = [];
    Users user = Provider.of<UserProvider>(context).getUser;
    favorites = user.favorites;
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("posts")
          .where("pid", whereIn: favorites)
          .get();
      setState(() {
        list = querySnapshot.docs.map((e) => Post.fromSnap(e)).toList();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          "Favorites",
          style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Container(
          height: 600,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: ListView.builder(
              itemCount: list.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return FoodCard(
                  post: list[index],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
