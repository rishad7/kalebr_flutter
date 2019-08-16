import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResultPage extends StatelessWidget {
  ResultPage(this.data);
  final data;
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(data['title']),
          backgroundColor: Color(0xff10163b),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          child: Text(
                            data['title'],
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
                            data['author'],
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
                                            'Shows Count',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          trailing: Text(
                                            data['showsCount'].toString(),
                                            style: TextStyle(
                                                color: Color(0xffff0067)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: SizedBox(
                                            height: 100.0,
                                            child: new ListView.builder(
                                              padding: EdgeInsets.all(10.0),
                                              scrollDirection: Axis.vertical,
                                              itemCount: data['shows'].length,
                                              itemBuilder: (BuildContext ctxt,
                                                  int index) {
                                                return new Text(
                                                    '${data['shows'][index]['showName']} : ' +
                                                        new DateFormat.yMMMd().format(
                                                            DateTime.parse(data[
                                                                        'shows']
                                                                    [index]
                                                                ['showDate'])));
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                          child: Card(
                            child: ListTile(
                              title: Text(
                                'ISBNS',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(data['isbns']),
                              isThreeLine: true,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Published on ' +
                                      new DateFormat.yMMMd().format(
                                          DateTime.parse(data['pubDate'])),
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
                  ),
                ],
              ),
            ),

            // width: 150.0,
            // height: 150.0,
            // decoration: BoxDecoration(
            //   color: Color(0xff7c94b6),
            //   image: DecorationImage(
            //     image: AssetImage('assets/book.jpg'),
            //     fit: BoxFit.cover,
            //   ),
            //   borderRadius: BorderRadius.all(Radius.circular(75.0)),
            //   border: Border.all(
            //     color: Colors.red,
            //     width: 4.0,
            //   ),
            // ),
          ),
        ),
      );
}
