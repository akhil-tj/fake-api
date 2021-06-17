// HTTP trial app

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fake API'),
        ),
        body: AppBody(),
      ),
    );
  }
}

class AppBody extends StatefulWidget {
  @override
  _AppBodyState createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  Future getUserData() async {
    var response = await http.get(
      Uri.https('jsonplaceholder.typicode.com', 'users'),
    );
    // print(response);
    var jsonData = jsonDecode(response.body);
    // print(jsonData.toString());
    List<User> users = [];

    for (var u in jsonData) {
      User user = User(userName: u['name'], userEmail: u['email']);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: FutureBuilder(
          future: getUserData(),
          builder: (context, snapshot) {
            // print(snapshot.data);
            if (snapshot.data == null) {
              return Text('Loading...');
            } else
              return Container(
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text(snapshot.data[i].userName),
                      subtitle: Text(snapshot.data[i].userEmail),
                    );
                  },
                ),
              );
          },
        ),
      ),
    );
  }
}

class User {
  String userName;
  String userEmail;
  User({this.userEmail, this.userName});
}
