import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './screens/homepage.dart';
import './screens/reviewpage.dart';
import './screens/tvpage.dart';

class InputPage extends StatelessWidget {
  final String title;

  InputPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Color(0xff10163b),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: Material(
            color: Color(0xff10163b),
            child: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.rate_review)),
                Tab(icon: Icon(Icons.tv)),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              HomePage(),
              ReviewPage(),
              TvPage(),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 93.0,
              child: DrawerHeader(
                child: Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xff10163b),
                ),
              ),
            ),
            ListTile(
              title: Text('Genres'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Lists'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Login'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  var cities = [];
  var recentCities = [
    'ABC, Baby Me!',
    'Moonwalking With Einstein',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    return null;
  }

  Future<String> getSearchData(String searchWord) async {
    String url =
        "http://www.rishadkalebrproject.tk/restapi/index.php?search_keyword=" +
            searchWord;
    var response = await http.get(
        // encode the url
        Uri.encodeFull(url),
        // only accept json response
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      var convertDataToJson = json.decode(response.body);

      cities = [];
      for (var post in convertDataToJson) {
        //cities.add(post['title'].toString());
      }

      cities.add('The Sweet Flypaper of Life');
      cities.add('Heads of the Colored People: Stories');
      cities.add('ABC, Baby Me!');
      cities.add('ABCD : An Alphabet Book of Cats and Dogs');
      cities.add('Moonwalking With Einstein');
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }

    return "success";
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    getSearchData(query);

    // show when someone searches for something
    final suggestionList = query.isEmpty
        ? recentCities
        : cities.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          Navigator.pop(context);
        },
        title: RichText(
            text: TextSpan(
                text: suggestionList[index].substring(0, query.length),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
              TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey)),
            ])),
        leading: Icon(Icons.book),
      ),
      itemCount: suggestionList.length,
    );
  }
}
