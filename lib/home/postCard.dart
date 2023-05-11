import 'package:flutter/material.dart';
import 'package:senior_hekmat/models/post.dart';

import 'details_page.dart';

//hed page ll card tb3 post li btlbo bl home page w fi m3lomet l post tb3 firebase


class FoodCard extends StatelessWidget {
  Post post;
   FoodCard({super.key,required this.post,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  DetailsScreen(post: post,)),
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
    margin: EdgeInsets.only(top: 30), // Add 20 pixels of padding to the top
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
        image: NetworkImage(post.image),
        fit: BoxFit.cover, // To fill the circle
      ),
    ),
  ),
),

 Positioned(
              right: 20,
              top: 80,
              child: Text(
                post.price+'€',
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)
              ),
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
                      post.title,
                      style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                    ),
                   
                    SizedBox(height: 16),
                    Text(
                      post.description,
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