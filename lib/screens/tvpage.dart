import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'resultpage.dart';

class TvPage extends StatefulWidget {
  @override
  TvPageState createState() => TvPageState();
}

class TvPageState extends State<TvPage> {
  final myController = TextEditingController();
  List data;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  Future<String> makeRequest(String searchWord) async {
    String url = "http://idreambooks.com/api/books/show_features.json?q=" +
        searchWord +
        "&key=87a4df24c1a3f60413ca13183bc2fc3f8edac7f3";
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      setState(() {
        var convertDataToJson = json.decode(response.body);
        data = convertDataToJson['books'];
      });
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: myController,
            decoration: InputDecoration(
              hintText: "Title OR Author OR ISBN",
            ),
          ),
          RaisedButton(
            color: Color(0xff10163b),
            onPressed: () {
              this.makeRequest(myController.text);
            },
            child: Text(
              'Search',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        data[index]['title'],
                        style: TextStyle(color: Color(0xff10163b)),
                      ),
                      subtitle: Text(data[index]['author']),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/book.jpg'),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ResultPage(data[index])));
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
