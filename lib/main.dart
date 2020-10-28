import 'package:auth_app/afterLogin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'authentication_methods.dart';
import 'package:fluttertoast/fluttertoast.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Demo',
      home: MyHomePage(title: 'Firebase Auth Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   AuthenticationMethods().getCurrentUser();
  }
  FToast fToast;
  bool ifSignedIn;
  String email;
  String password;
  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("This is a Custom Toast"),
        ],
      ),
    );


    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );

    // Custom Toast Position
    fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            top: 16.0,
            left: 16.0,
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Auth"),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              email = value;
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          TextField(
            onChanged: (value) {
              password = value;
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          FlatButton(
            onPressed: () async {
              AuthenticationMethods().signUpWithEmail(email, password);
            },
            child: Container(
              color: Colors.blue,
              child: Text("Sign up"),
            ),
          ),
          FlatButton(
            onPressed: () async {
             ifSignedIn= await AuthenticationMethods().signInWithEmail(email,password);
             if(ifSignedIn!=false){
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => afterlogin()),
               );
             }
              else{
                print("Sign in unsuccessful with email and password");
             }
            },
            child: Container(
              color: Colors.blue,
              child: Text("Sign in"),
            ),
          ),
          FlatButton(
            onPressed: () {
              AuthenticationMethods().signOut();
            },
            child: Container(
              color: Colors.blue,
              child: Text("Sign out"),
            ),
          ),
          FlatButton(
            onPressed: () async {
              ifSignedIn=await AuthenticationMethods().signInWithGoogle();
              ifSignedIn?Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => afterlogin()),
              ):print("Sign in Unsuccessful");
            },
            child: Container(
              color: Colors.blue,
              child: Text("Sign in with google"),
            ),
          ),

        ],
      ),
    );
  }
}
