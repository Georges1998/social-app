import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_frontend/models/user.dart';
import 'package:mobile_frontend/pages/home.dart';
import 'package:mobile_frontend/widgets/progress.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  Future<QuerySnapshot> searchResultsFuture;

  handleSearch(String query) {
    Future<QuerySnapshot> users =
        userRef.where('displayName', isGreaterThanOrEqualTo: query).getDocuments();
    setState(() {
      searchResultsFuture = users;
    });
  }

  buildSearchField() {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: TextFormField(
        controller: searchController,
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
                onPressed: clearSearch)),
        onFieldSubmitted: handleSearch,
      ),
    );
  }

  clearSearch() {
    searchController.clear();
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

  buildSearchResults() {
    return FutureBuilder(
        future: searchResultsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
          List<UserResult> searchResults = [];
          snapshot.data.documents.forEach((doc) {
            User user = User.fromDocument(doc);
            UserResult searchResult = UserResult(user);
            searchResults.add(searchResult);
          });
          return ListView(
            children: searchResults,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(1),
      appBar: buildSearchField(),
      body:
          searchResultsFuture == null ? buildNoContent() : buildSearchResults(),
    );
  }
}

class UserResult extends StatelessWidget {
  final User user;
  UserResult(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor.withOpacity(0.5),
      child: Column(
        children: <Widget>[
          GestureDetector(
              onTap: () => print(user.username),
              child: ListTile(
                title: Text(
                  user.displayName,
                  style: TextStyle(
                      color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(user.username),
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).accentColor,
                  backgroundImage: CachedNetworkImageProvider(user.photoURL),
                ),
              )),
          Divider(
            height: 2.0,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
