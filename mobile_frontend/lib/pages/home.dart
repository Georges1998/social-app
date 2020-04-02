import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_frontend/pages/activity_feed.dart';
import 'package:mobile_frontend/pages/profile.dart';
import 'package:mobile_frontend/pages/search.dart';
import 'package:mobile_frontend/pages/timeline.dart';
import 'package:mobile_frontend/pages/upload.dart';

final googleSignIn = GoogleSignIn();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();

    // --------------------> Login/Logout
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    }, onError: (err) {
      print("Error sigining in: $err");
    });
    // Reauthenticate users when app is open
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }).catchError((err) {
      print("Error sigining in: $err");
    });
  }

  handleSignIn(GoogleSignInAccount account) {
    if (account != null) {
      setState(() {
        isAuth = true;
      });
      print("account is authenticated: $account");
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  login() {
    googleSignIn.signIn();
  }

  logout() {
    googleSignIn.signOut();
  }
  // Login/Logout <--------------------

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  changePage(int pageIndex) {
    pageController.jumpToPage(pageIndex);
  }

  // --------------------> AuthPage
  Widget buildAuthScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Timeline(),
          ActivityFeed(),
          Upload(),
          Search(),
          Profile(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Color(0xfff5f5f5),
        currentIndex: pageIndex,
        onTap: changePage,
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: Colors.blueGrey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.attach_money)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active)),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.camera_alt,
            size: 40.0,
          )),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle)),
        ],
      ),
    );
  }
  // AuthPage <--------------------

  // --------------------> UnAuthPage
  Scaffold buildUnAuthScreen() {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Theme.of(context).accentColor, Colors.blue])),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "RichieRich",
            style: TextStyle(
                fontSize: 65.0, color: Colors.white, fontFamily: 'LuckiestGuy'),
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
  // UnAuthPage <--------------------

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}
