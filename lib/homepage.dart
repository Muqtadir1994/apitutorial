import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/postmodel.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomepageState();
  }
}

class HomepageState extends State<Homepage> {
//list of type potmodel
  List<Postmodel> postlist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Api'),
        ),
        body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: postlist.length,
                  itemBuilder: (context, index) {
                    return Container(
                      //height: 130,
                      color: Colors.greenAccent,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User id: ${postlist[index].userId}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            'Id: ${postlist[index].id}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            'Title : ${postlist[index].title}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            'Body: ${postlist[index].body}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

//creat a future method of type list of type postmodel
  Future<List<Postmodel>> getData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
//
    //decoding response and store in data var
    var data = jsonDecode(response.body.toString());
    //
    //check if response is prossed successfully
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        postlist.add(Postmodel.fromJson(i));
      }
      return postlist;
    } else {
      //empty list
      return postlist;
    }
  }
}
