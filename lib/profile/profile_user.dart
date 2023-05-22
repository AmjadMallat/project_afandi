import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../auth_page.dart/provider/provider.dart';
import '../models/user.dart';

class PorfileUser extends StatelessWidget {
  const PorfileUser({super.key});

  @override
  Widget build(BuildContext context) {
    Users user = Provider.of<UserProvider>(context,listen: false).getUser;
 String profileUrl='';
    return
    user== null
        ? const CircularProgressIndicator()
        :
     DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //profile picture
                  Container(
                    height: 80,
                    width: 80,
                    // child: user. != ""
                    //     ?
                        child: CircleAvatar(
                            radius: 80,
                            backgroundImage: NetworkImage(user.profile),
                          ),
                          
                  ),

                  //number of posts, followers, following
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              "7",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.black),
                            ),
                            Text(
                              "Posts",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "230",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.black),
                            ),
                            Text(
                              "Following",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "400",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.black),
                            ),
                            Text(
                              "Followers",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.firstName + " " + user.lastName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black),
                  ),
               
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.00),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Container(
                        padding: EdgeInsets.all(0),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: TextButton(
                                onPressed: () async{
                                  
 //step 1 pick an image (img picker)
                      ImagePicker imagePicker = ImagePicker();
                      XFile? file =
                          await imagePicker.pickImage(source: ImageSource.gallery);
                      print('${file?.path}');
      
                      if (file == null) return;
      
                      String uniqueFileName =
                          DateTime.now().millisecondsSinceEpoch.toString();
      
                      //step 2 upload the image to firebase storage
      
                      //get a reference to storage root
                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      Reference referenceDirImages =
                          referenceRoot.child("profiles");
      
                      //create a reference for the image to be stored
                      Reference referenceImageToUpload =
                          referenceDirImages.child(uniqueFileName);
      
                      try {
                        //store the file
                        await referenceImageToUpload.putFile(File(file.path));
                        //get the url
                        profileUrl = await referenceImageToUpload.getDownloadURL();
                        User currentUser = FirebaseAuth.instance.currentUser!;
                        FirebaseFirestore.instance.collection("users").doc(currentUser.uid).update(<String,dynamic>{"profile":profileUrl});
                      } catch (error) {}
                                },
                                child: Text("Edit Profile")),
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Container(
                        padding: EdgeInsets.all(0),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: TextButton(
                                onPressed: () {
// Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => ListFriends()),
//                                   );

                                }, child: Text("Friends")),
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TabBar(tabs: [
              Tab(
                icon: Icon(
                  Icons.grid_3x3_outlined,
                  color: Colors.grey,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.add_box,
                  color: Colors.grey,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.shop_2_sharp,
                  color: Colors.grey,
                ),
              ),
            ]),
            Expanded(
                child: TabBarView(
              children: [
                // AccountTabPosts(),
                // AddPostProfile(),
                // AccountTabShop(),
              ],
            )),
          ],
        ),
      ),
    );
  
  }
}