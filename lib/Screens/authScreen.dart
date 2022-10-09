import 'package:flutter/material.dart';
import 'package:taskmanager/providers/authProvider.dart';
import 'package:taskmanager/utils/google_sign_in_button.dart';
import 'package:provider/provider.dart';

class Auth extends StatelessWidget {
  //const Auth({Key? key}) : super(key: key);
  var size;

  void init() {}

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            width: size.width,
            decoration: BoxDecoration(color: Colors.indigo.shade900),
            child: Column(
              children: [
                SizedBox(
                  height: size.height / 3,
                ),
                const Text(
                  "Welcome",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Login/SignUp to continue:",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                SizedBox(
                  height: size.height / 10,
                ),
                FutureBuilder(
                  future: Provider.of<Authentication>(context, listen: false)
                      .initializeFirebase(context: context),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error initializing Firebase');
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return GoogleSignInButton();
                    }
                    return const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.blue,
                      ),
                    );
                  },
                ),
                /*InkWell(child:Container(height: 55,width: 250,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(8)),child:
        Row(mainAxisAlignment: MainAxisAlignment.center,children: [
          Text("Sign in using",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white),),
       SizedBox(width: 7,),Icon(Icons.facebook,color: Colors.white,size: 24,) ],),))*/
              ],
            )));
  }
}
