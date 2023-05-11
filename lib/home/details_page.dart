import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:senior_hekmat/home/payment_screen.dart';

import '../models/post.dart';

//he details page btlob fya title w desc tb3on post la shof more details 3no


class DetailsScreen extends StatefulWidget {
  Post post;
  DetailsScreen({super.key, required this.post});
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaymentScreen()),
                        );
        },
        child: Icon(Icons.shopping_bag),
        backgroundColor: Colors.orange.withOpacity(.7),
      ),
      appBar: AppBar(
        title: Text(
          "Details Screen",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange.withOpacity(.7),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // GestureDetector(
                //   onTap: () {
                //     Navigator.pop(context);
                //   },

                // ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(6),
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Set the shape to circle
                  image: DecorationImage(
                    image: NetworkImage(widget.post.image),
                    fit: BoxFit.cover, // To fill the circle
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.post.title,
                      ),
                    ],
                  ),
                ),
                Text(
                  '${widget.post.price} €',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: "PathwayExtreme",
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.withOpacity(.9),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ReadMoreText(
              "\n" + widget.post.description,
              trimLines: 5,
              textAlign: TextAlign.justify,
              trimMode: TrimMode.Line,
              trimCollapsedText: "Show More",
              moreStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              //trimExpandedText: "Show Less",
              lessStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              style: TextStyle(
                color: Colors.black.withOpacity(.7),
                fontSize: 16.0,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
