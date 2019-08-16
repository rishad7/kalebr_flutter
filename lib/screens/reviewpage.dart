import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ReviewPage extends StatefulWidget {
  @override
  ReviewPageState createState() => ReviewPageState();
}

class ReviewPageState extends State<ReviewPage> {
  final myController = TextEditingController();
  List data;
  var bookData;
  var totalResult;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  Future<String> makeRequest(String searchWord) async {
    String url = 'http://idreambooks.com/api/books/reviews.json?q=' +
        searchWord +
        '&key=87a4df24c1a3f60413ca13183bc2fc3f8edac7f3';

    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      setState(() {
        var convertDataToJson = json.decode(response.body);
        bookData = convertDataToJson['book'];
        totalResult = convertDataToJson['total_results'];
        data = convertDataToJson['book']['critic_reviews'];
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
                itemCount: totalResult.toString() == '1' ? 1 : 0,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          child: Text(
                            bookData['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff10163b),
                              fontSize: 20.0,
                            ),
                          ),
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                        ),
                        Container(
                          child: Text(
                            bookData['author'],
                            style: TextStyle(
                              color: Color(0xffff0067),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 140.0,
                                height: 200.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xff10163b),
                                    width: 2.0,
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/book.jpg'),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: Card(
                                        child: ListTile(
                                          title: Text(
                                            'Review Count',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          trailing: Text(
                                            bookData['review_count'].toString(),
                                            style: TextStyle(
                                                color: Color(0xffff0067)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Card(
                                        child: ListTile(
                                          title: Text(
                                            'Rating',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          trailing: Text(
                                            bookData['rating'].toString() != 'null' ? bookData['rating'].toString() : '',
                                            style: TextStyle(
                                                color: Color(0xffff0067)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Card(
                                        child: ListTile(
                                          title: Text(
                                            'Pages',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          trailing: Text(
                                            bookData['pages'].toString(),
                                            style: TextStyle(
                                                color: Color(0xffff0067)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: SizedBox(
                                height: 300.0,
                                child: new ListView.builder(
                                  padding: EdgeInsets.all(10.0),
                                  scrollDirection: Axis.vertical,
                                  itemCount: data == null ? 0 : data.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return Card(
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              data[index]['source_logo']),
                                        ),
                                        title: Text(data[index]['source']),
                                        subtitle: Text(data[index]['snippet']),
                                        isThreeLine: true,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Released Date : ' +
                                      new DateFormat.yMMMd().format(
                                          DateTime.parse(
                                              bookData['release_date'])),
                                  style: TextStyle(
                                    color: Color(0xff244b90),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
