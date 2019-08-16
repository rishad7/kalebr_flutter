import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List data;
  bool isLoading;

  @override
  void initState() {
    super.initState();
    this.getJsonData('all-books');
  }

  Future<String> getJsonData(String slug) async {
    isLoading = false;
    String url =
        "http://idreambooks.com/api/publications/recent_recos.json?key=87a4df24c1a3f60413ca13183bc2fc3f8edac7f3&slug=" +
            slug;
    var response = await http.get(
        // encode the url
        Uri.encodeFull(url),
        // only accept json response
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      setState(() {
        var convertDataToJson = json.decode(response.body);
        data = convertDataToJson;
        isLoading = true;
      });
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }

    return "success";
  }

  String dropdownValue = 'all-books';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
                getJsonData(dropdownValue);
              },
              items: <String>[
                'all-books',
                'bestsellers',
                'fiction',
                'non-fiction',
                'action-adventure',
                'arts-photography',
                'biographies-memoirs',
                'business-economics',
                'children-s-books',
                'comics-graphic-novels',
                'computers-technology',
                'cooking',
                'crafts-hobbies-home',
                'crime',
                'current-affairs',
                'education-reference',
                'erotica',
                'gay-lesbian',
                'health-fitness-dieting',
                'history',
                'horror',
                'humor-entertainment',
                'law-philosophy',
                'literature-fiction',
                'mystery-thriller-suspense',
                'nature-wildlife',
                'other',
                'parenting-relationships',
                'political-social-sciences',
                'professional-technical',
                'religion-spirituality',
                'romance',
                'science-math',
                'science-fiction-fantasy',
                'self-help',
                'sports-outdoors',
                'travel',
                'war',
                'westerns',
                'young-adult',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Expanded(
              child: isLoading
                  ? ListView.builder(
                      itemCount: data == null ? 0 : data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          data[index]['title'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff10163b),
                                          ),
                                        ),
                                        padding: EdgeInsets.fromLTRB(
                                            10.0, 10.0, 10.0, 5.0),
                                      ),
                                      Container(
                                        child: Text(
                                          data[index]['author'],
                                          style: TextStyle(
                                            color: Color(0xffff0067),
                                          ),
                                        ),
                                        padding:
                                            EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                                      ),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 70.0,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                // borderRadius: BorderRadius.only(
                                                //   bottomLeft: Radius.circular(5),
                                                //   topLeft: Radius.circular(5),
                                                // ),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      'assets/book.jpg'),
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: new Text(
                                                data[index]['review_snippet'],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                data[index]
                                                    ['review_publication_name'],
                                                style: TextStyle(
                                                  color: Color(0xff10163b),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                'Reviewed on ' +
                                                    new DateFormat.yMMMd()
                                                        .format(DateTime.parse(
                                                            data[index][
                                                                'review_date'])),
                                                style: TextStyle(
                                                  color: Color(0xff244b90),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(
                                                      'Rating ',
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 22.0,
                                                    height: 12.0,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(data[
                                                                index][
                                                            'review_rating_image']),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          child: CircularProgressIndicator(),
                          height: 50.0,
                          width: 50.0,
                        ),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}
