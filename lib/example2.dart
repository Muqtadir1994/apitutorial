import 'dart:convert';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//import 'models/postmodel.dart';

class Homepage2 extends StatefulWidget {
  const Homepage2({super.key});

  @override
  State<StatefulWidget> createState() {
    return Homepage2State();
  }
}

class Homepage2State extends State<Homepage2> {
//list of type potmodel
  List<Photo> phlist = [];

  Future<List<Photo>> getPhoto() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        Photo ph = Photo(title: i['title'], url: i['url']);
        phlist.add(ph);
      }
      return phlist;
    } else {
      return phlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Api'),
        ),
        body: FutureBuilder(
          future: getPhoto(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: phlist.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(phlist[index].url)),
                  title: Text('Title: ${phlist[index].title}'),
                );
              },
            );
          },
        ));
  }
}

// json model

class Photo {
  late String title, url;

  Photo({required this.title, required this.url});
}
