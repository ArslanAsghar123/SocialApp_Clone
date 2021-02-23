import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Container buildNoContent() {
    return Container(

      child: ListView(
        shrinkWrap: true,
        children: [
          Image.asset('assets/images/search.png',height: 360,),
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

  AppBar buildSearchResult() {
    return AppBar(
      backgroundColor: Colors.white,
      title: TextFormField(
        decoration: InputDecoration(
            hintText: "Search for user...",
            filled: true,
            prefixIcon: Icon(
              Icons.account_box,
              size: 28.0,
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {},
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
      appBar: buildSearchResult(),
      body: buildNoContent(),
    );
  }
}

class SearchResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
