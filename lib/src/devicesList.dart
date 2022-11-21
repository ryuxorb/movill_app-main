
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Post>> fetchPost() async {
  final response =
  await http.get(Uri.parse('https://movill-api.two4.de/device/listall'));

  if (response.statusCode == 200) {
    print(response.statusCode);
    List list = jsonDecode(response.body);
    var postList = list.map((element) => Post.fromJson(element)).toList();
    return postList;
  } else {
    throw Exception('Failed to load post');
  }
}

class Post {
  final String id;
  final String deviceKey;
  final String deviceName;
  final String deviceKind;
  final String deviceOwnerId;
  final String deviceState;
  //final String lastX;
  //final String lastY;

  Post({required this.id, required this.deviceKey,
    required this.deviceName, required this.deviceKind,
    required this.deviceOwnerId, required this.deviceState,
    //required this.lastX, required this.lastY
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      deviceKey: json['deviceKey'],
      deviceName: json['deviceName'],
      deviceKind: json['deviceKind'],
      deviceOwnerId: json['deviceOwnerId'],

      deviceState: json['deviceState'],
      //lastX: json['lastX'],
      //lastY: json['lastY'],
    );
  }
}


class DeviceList extends StatefulWidget {
  DeviceList({Key? key}) : super(key: key);

  @override
  _DeviceListState createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  late Future<List<Post>> postList;

  @override
  void initState() {
    super.initState();
    postList = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FutureBuilder<List<Post>>(
            future: postList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index){
                    Post post = snapshot.data![index];
                    return Card(
                        child: ListTile(
                          title: Text(post.deviceKey.toString()),
                        )
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}