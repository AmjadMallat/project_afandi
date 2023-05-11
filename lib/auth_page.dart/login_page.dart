import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senior_hekmat/auth_page.dart/ragister_page.dart';

//hedi page login w ma3 function l firebase li mn 5lela b3mla sign in with email 
//w m3on textcontroller la 7ta a3ml add mn 5lel ll information


class LoginPage extends StatefulWidget {
    final Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

//he hye l function tb3it firebase sign in

void signInUser() async {
  showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
    

    if(mounted){
      Navigator.pop(context);
    }
  } on FirebaseAuthException catch (e) {
    if(mounted){
      ShowErrorMessage(e.code);
    }
  }
}


  void ShowErrorMessage(String mesage) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.orange,
            title: Center(
              child: Text(
                mesage,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    
//w hon klshi desgin w button 3mlnehon

     return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                Image.asset('images/logo_senior.png'), 
                //hello again
               
                SizedBox(
                  height: 50,
                ),

                //email textfield
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
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.email,color: Colors.orange,),
                          hintText: 'Email',
                        ),
                      ),
                    ),
                  ),
                ),
                //password textfield
                SizedBox(
                  height: 20,
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
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.password,color: Colors.orange,),
                          hintText: 'Password',
                        ),
                      ),
                    ),
                  ),
                ),

                //sign in button
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                  ),
                  child: GestureDetector(
                    onTap: (){
                      signInUser();
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //not a member? register now
                SizedBox(
                  height: 25,
                ),
                  //or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.orange,fontSize: 15),
                      ),
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 0.8,
                      
                    ))
                  ],
                ),
              ),
              SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

GestureDetector(
  onTap: widget.onTap,
  child: Text(" Register Now",style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold)),
),


//                    TextButton(
//             style: TextButton.styleFrom(
//               textStyle: const TextStyle(fontSize: 20),
//             ),
//             onPressed: () {
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => const RegisterPage()),
//   );
// },
//             child: const Text('Register now',style: TextStyle(color: Colors.orange),),
//           ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}