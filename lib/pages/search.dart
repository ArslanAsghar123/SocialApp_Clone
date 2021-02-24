import 'package:flutter/material.dart';
import 'package:socialapp/models/user.dart';
import 'package:socialapp/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cached_network_image/cached_network_image.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  Future<QuerySnapshot> searchResultsFuture;

  Container buildNoContent() {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: [
          Image.asset(
            'assets/images/search.png',
            height: 360,
          ),
          Text(
            'Find User',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              fontSize: 60,
            ),
          )
        ],
      ),
    );
  }

  handleSearch(String query) {
    Future<QuerySnapshot> users = firestoreInstance
        .collection('users')
        .where("displayName", isGreaterThanOrEqualTo: query)
        .get();
    setState(() {
      searchResultsFuture = users;
    });
  }

  AppBar buildSearchField() {
    return AppBar(
      backgroundColor: Colors.white,
      title: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Search for user...",
          filled: true,
          prefixIcon: Icon(
            Icons.account_box,
            size: 28.0,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: clearSearch,
          ),
        ),
        onFieldSubmitted: handleSearch,
      ),
    );
  }

  clearSearch() {
    searchController.clear();
  }

  buildSearchResult() {
    return FutureBuilder(
      future: searchResultsFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        List<SearchResult> searchResults = [];
        snapshot.data.docs.forEach((doc) {
          User user = User.fromDocument(doc);
          SearchResult searchResult = SearchResult(user);
          searchResults.add(searchResult);
        });
        return ListView(
          children: searchResults,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
      appBar: buildSearchField(),
      body:
          searchResultsFuture == Null ? buildNoContent() : buildSearchResult(),
    );
  }
}

class SearchResult extends StatelessWidget {
  final User user;

  SearchResult(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor.withOpacity(0.8),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => print('ontap'),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: CachedNetworkImageProvider(user.photoUrl),
              ),
              title: Text(user.displayName,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            subtitle: Text(user.username,style: TextStyle(color: Colors.white),),
            ),
          ),
          Divider(
            height: 2.0,
            color: Colors.white54,
          )
        ],
      ),
    );
  }
}
