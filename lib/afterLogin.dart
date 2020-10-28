import 'package:auth_app/main.dart';
import 'package:flutter/material.dart';
import 'authentication_methods.dart';
import 'main.dart';
class afterlogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Sign In Successful",
              style: TextStyle(fontSize: 35.0),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            width: 100.0,
            height: 50.0,
            color: Colors.blue,
            child: FlatButton(
              onPressed: () {
               Future<bool> signOutSucess= AuthenticationMethods().signOut();
               if(signOutSucess != false){
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => MyHomePage()),
                 );

               }
              },
              child: Text(
                "Sign Out",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
