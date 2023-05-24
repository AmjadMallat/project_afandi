
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:senior_hekmat/home/postCard.dart';

import '../models/post.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}


//hon lal search page li ana b2dr mn 5lela a3ml search 3la post 7sb title tb3o iza mwjod aw laa
class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();

  List<Post> searchResult = [];
  bool isLoading = false;

  void onSearch() async {
    setState(() {
      isLoading = true;
    });

    final querySnapshot = await FirebaseFirestore.instance
        .collection('posts')
        //hon ana hed l controller hwa li b3ml fi l filter la a3rf iza post mwjod 
        .where("title", isEqualTo: _searchController.text)
        .get();

    if (querySnapshot.docs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No Position found")),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    setState(() {
      searchResult = querySnapshot.docs.map((doc) => Post.fromSnap(doc)).toList();

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Search Screen"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Type the position....",
                        hintStyle: TextStyle(
                          color: Colors.black, // set the color of the hint text
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )),
              ),
              IconButton(
                  onPressed: () {
                    onSearch();
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  )),
            ],
          ),
          if (searchResult.length > 0)
            Expanded(
              child: ListView.builder(
                itemCount: searchResult.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return FoodCard(
                    post: searchResult[index],
                  );
                },
              ),
            )
          else if (isLoading == true)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
