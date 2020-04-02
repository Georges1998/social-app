import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignIn = GoogleSignIn();
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;

  @override
  void initState() { 
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((account){
      if(account!=null){
        setState(() {
          isAuth = true;
        });
        print("account is authenticated: $account");
      }else{
        setState(() {
          isAuth = false;
        });
      }
    });
  }
  login(){
    googleSignIn.signIn();
  }

  Widget buildAuthScreen() {
    return Text('Authenticated');
  }

  Scaffold buildUnAuthScreen() {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.teal, Colors.blue])),
              alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "RichieRich",
            style: TextStyle(fontSize: 80.0, color: Colors.white, fontFamily: 'Signatra'),
          ),
          GestureDetector(
            onTap: login,
            child: Container(
              width: 260,
              height: 60,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage("assets/images/google_signin_button.png"),
                      fit: BoxFit.cover)),
            ),
          )
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}
