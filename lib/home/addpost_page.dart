import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:senior_hekmat/components/button.dart';


//he page add post 3n tari2 l user  w b3mla add 3l firebase mtl ma b3ml add ll user details

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  String imageUrl = '';
//text editing controllers
  final _title = TextEditingController();
  final _price = TextEditingController();
  final _description = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    _price.dispose();
    _description.dispose();
    super.dispose();
  }

//button add the post and give the data

  void Post() async {
    //show loading in method
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

//add post details
    try {
      await addPostDetails(_title.text.trim(), _price.text.trim(),
          _description.text.trim(), imageUrl);

      //pop loading circle
    } on FirebaseFirestore catch (e) {
      //show error message
      print(e);
    }
    Navigator.pop(
      context,
    );
  }

//details user
  Future addPostDetails(
      String title, String price, String description, String imageUrl) async {
    await FirebaseFirestore.instance.collection('posts').add({
      'title': title,
      'price': price,
      'description': description,
      'image': imageUrl,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          
          //he image picker bjib fya swar w files mn phone tb3i
//w bosla b3dn ll image b storage l firebase w bjib link b7to b image l post

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
          Reference referenceDirImages = referenceRoot.child("images");

          //create a reference for the image to be stored
          Reference referenceImageToUpload =
              referenceDirImages.child(uniqueFileName);

          try {
            //store the file
            await referenceImageToUpload.putFile(File(file.path));
            //get the url
            imageUrl = await referenceImageToUpload.getDownloadURL();
          } catch (error) {}
        },
        child: Icon(Icons.add_a_photo),
        backgroundColor: Colors.orange.withOpacity(.9),
      ),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: Text(
                'Start Post!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),


  
    


              SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _title,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'add title',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                ),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  controller: _description,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  decoration: InputDecoration(
                      hintText: "Description",
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.orange))),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.only(left: 100, right: 100),
                child: TextField(
                  controller: _price,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    
                  
                    hintText: "0 \$",
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              MyButton(
                text: "Post",
                onTap: Post,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
