import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutterfire_samples/screens/user_info_screen.dart';
//import 'package:flutterfire_samples/utils/authentication.dart';
import 'package:taskmanager/google/screens/user_info_screen.dart';
import 'package:taskmanager/providers/authProvider.dart';
import 'package:taskmanager/utils/authentication.dart';

//import 'package:plato_mobile/utils/authentication.dart';
import 'package:provider/provider.dart';



class GoogleSignInButton extends StatelessWidget {
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

                User? user =await Provider.of<Data>(context, listen: false).signInWithGoogle(context: context);
                    //await Authentication.signInWithGoogle(context: context);
                print(user!.email);



                if (user != null) {
                  UserInfoScreen(
                        user: user,

                  );
                }
              },
              child: Container(height: 55,width: 250,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(8)),child:Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                Text("Sign in using",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white),),
                SizedBox(width: 27,),Image.asset("assets/google.png",width: 28,) ],),
              ),))

    );
  }
}
