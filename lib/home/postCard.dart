import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_hekmat/models/post.dart';
import 'package:senior_hekmat/models/user.dart';

import '../auth_page.dart/provider/provider.dart';
import 'details_page.dart';

//hed page ll card tb3 post li btlbo bl home page w fi m3lomet l post tb3 firebase

class FoodCard extends StatefulWidget {
  Post post;
  //Users user;
  FoodCard({
    super.key,
    required this.post,
    /*required this.user*/
  });

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
 Users? users;

  @override
  void initState() {
    super.initState();
    // getUserDetails();
    
  }


  Icon icon = Icon(
    Icons.favorite_border,
    size: 20,
  );


  @override
  Widget build(BuildContext context) {
    Users user = Provider.of<UserProvider>(context).getUser;
    UserProvider userprovider =
        Provider.of<UserProvider>((context), listen: false);

    Future<void> addFavorites() async {
      List<String> favorites = user.favorites;
      if (favorites.contains(widget.post.pid)) {
        favorites.remove(widget.post.pid);
        Icon(
          Icons.favorite,
          color: Colors.red,
        );
      } else {
        favorites.add(widget.post.pid);
        Icon(
          Icons.favorite_outline,
          color: Colors.blue,
        );
      }
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .update({"favorites": favorites});
      userprovider.refreshUser();
    }

    if (user.favorites.contains(widget.post.pid))
      icon = Icon(
        Icons.favorite,

        color: Colors.red,
      );
    else
      icon = Icon(
        Icons.favorite_outline,

        color: Colors.blue,
      );


    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsScreen(
                    post: widget.post,
                  )),
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 20),
        height: 400,
        width: 270,
        child: Stack(
          children: <Widget>[
            Positioned(
              right: 0,
              child: Container(
                height: 350,
                width: 250,
                margin: EdgeInsets.only(
                    top: 30), // Add 20 pixels of padding to the top
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(34),
                  color: Colors.orange.withOpacity(.6),
                ),
              ),
            ),
            Container(
              height: 181,
              width: 181,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange.withOpacity(.7),
              ),
            ),
            Positioned(
              top: 0,
              left: -50,
              child: Container(
                height: 184,
                width: 276,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Set the shape to circle
                  image: DecorationImage(
                    image: NetworkImage(widget.post.image),
                    fit: BoxFit.cover, // To fill the circle
                  ),
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: 100,
              child: Text(widget.post.price + '€',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
             Positioned(
              right: 10,
              top: 40,
              child: IconButton(
                                onPressed: () {
                                  addFavorites();
                                },
                                icon: icon),

            ),
            Positioned(
              top: 201,
              left: 40,
              child: Container(
                width: 210,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.post.title,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(
                      widget.post.description,
                      maxLines: 3,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
