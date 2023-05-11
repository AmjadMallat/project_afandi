import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:senior_hekmat/home/addpost_page.dart';
import 'package:senior_hekmat/home/postCard.dart';
import 'package:senior_hekmat/models/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

//w he home page la etlob fya posts mn 5lel query firebase 

 @override
  void initState() {
    super.initState();
    getPost();
  }

//

//
  List<Post> product = [];

//w he hye get post la jib mna list l posts

//to add a new post
  Future<void> getPost() async {
    List<Post> results = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("posts")
          .get();

      results = querySnapshot.docs.map((e) => Post.fromSnap(e)).toList();
      print("success");
    } catch (e) {
      print("fail");
      print(e);
    }
    setState(() {
      product = results;
    });
  }

//sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  
  @override
  Widget build(BuildContext context) {

return Scaffold(
  appBar: AppBar(
    leading: IconButton(onPressed: (){
signUserOut();
              }, icon: Icon(Icons.arrow_back,size: 30,),color: Colors.orange,),
    elevation: 0,
    backgroundColor: Colors.white,
  ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => AddPost()),
);
      },
child: Icon(Icons.add),
backgroundColor: Colors.orange.withOpacity(.6),
),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Align(
                alignment: Alignment.center,
                child: Text("      Welcome to\nAfandi Application",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),
                ),
              ),
            ),
      
       SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    IconButton(
                padding: EdgeInsets.only(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
                    PostTitle(title:"All", active: true,),
                    PostTitle(title:"Beirut", ),
                    PostTitle(title:"Tripoli",),
                    PostTitle(title:"Akkar", ),
                    PostTitle(title:"Sayda", ),
                    PostTitle(title:"Bekaa", ),
                  ],
                ),
              ),
       Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.orange),
              ),
              child: Icon(Icons.search,size: 25,),
            ),
      
              SizedBox(
                height: 0,
              ),
              Container(
                height: 660,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
      
                   child: ListView.builder(
                    itemCount: product.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return FoodCard(
                        post: product[index],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
      ),
      );
    



  }
}

class PostTitle extends StatelessWidget {
  final String title;
  final bool active;
  const PostTitle({
    super.key, required this.title,  this.active=false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: Text(title,
      style:Theme.of(context).textTheme.button?.copyWith(color:active?Colors.grey:Colors.black.withOpacity(0.4)),
      
 
      ),
    );
  }
}