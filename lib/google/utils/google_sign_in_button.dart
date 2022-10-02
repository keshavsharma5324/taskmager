import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutterfire_samples/screens/user_info_screen.dart';
//import 'package:flutterfire_samples/utils/authentication.dart';
import 'package:taskmanager/google/screens/user_info_screen.dart';
import 'package:taskmanager/google/utils/authentication.dart';

//import 'package:plato_mobile/utils/authentication.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: _isSigningIn
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : Container(height: 43,child:InkWell(
              /*style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),*/
              onTap: () async {
                setState(() {
                  _isSigningIn = true;
                });
                User? user =
                    await Authentication.signInWithGoogle(context: context);

                setState(() {
                  _isSigningIn = false;
                });

                if (user != null) {
                  UserInfoScreen(
                        user: user,

                  );
                }
              },
              child: Container(decoration: BoxDecoration( color: Color(0xffF5F5F5),borderRadius: BorderRadius.all(Radius.circular(5))),height: 43,width: MediaQuery.of(context).size.width/2-43,child:
              Row(mainAxisAlignment: MainAxisAlignment.center,children:[

                // SizedBox(width: 20,),//fit: BoxFit.fill,),
                Text('Sign in using',style: TextStyle(letterSpacing: 0.24,color: Color(0xffA1A4C1),fontWeight: FontWeight.w400,fontSize: 12,fontFamily: 'Helvetica'),),SizedBox(width: 0,),Container(height: 43,width: 38,child: Image.asset('assets/png/google.png')),]),),),)

    );
  }
}
