import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  buildSearchField() {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: TextFormField(
        style: TextStyle(
          color: Theme.of(context).accentColor,
        ),
        decoration: InputDecoration(
            hintText: "Search for a user...",
            hintStyle: TextStyle(color: Theme.of(context).accentColor),
            filled: true,
            fillColor: Theme.of(context).accentColor.withOpacity(0.3),
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).accentColor,
              size: 28,
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              color: Theme.of(context).accentColor,
              onPressed: () {
                print("Cleared");
              },
            )),
      ),
    );
  }

  buildNoContent() {
    return Container(
      height: double.infinity,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Center(
              child: Padding(
            padding: EdgeInsets.only(top: 120),
            child: Text(
              "Find Users",
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 60,
                  fontFamily: "LuckiestGuy"),
            ),
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: buildSearchField(),
      body: buildNoContent(),
    );
  }
}

class UserResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("User Result");
  }
}
