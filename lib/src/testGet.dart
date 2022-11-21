import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListViewJSON extends StatefulWidget {
  const ListViewJSON({Key? key}) : super(key: key);

  @override
  _ListViewJSONState createState() => _ListViewJSONState();
}

class _ListViewJSONState extends State<ListViewJSON> {
  Future<List<PostData>> _getPost() async {
    // http 0.12.2 로 하면 에러가 발생하지 않고 http 0.13.4 로 하면 에러 발생
    final response =
    await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<PostData> postDatas = [];

      for (var item in jsonData) {
        PostData postData =
        PostData(item['userId'], item['id'], item['title'], item['body']);
        postDatas.add(postData);
      }
      //print("데이터 개수 : ${postDatas.length}");
      return postDatas;
    } else {
      throw Exception('Failed to load postData');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: _getPost(),
          builder: (context, AsyncSnapshot snapshot) {

            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(snapshot.data[index].title),
                        subtitle: Text(snapshot.data[index].body),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPage(snapshot.data[index])));
                        },
                      ),
                    );
                  });
            } else {
              return Container(
                child: Center(
                  child: Text("Loading..."),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final PostData postData;

  DetailPage(this.postData); // 생성자를 통해서 입력변수 받기

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: Container(
        child: Center(
          child: Text(postData.title),
        ),
      ),
    );
  }
}

class PostData {
  final int userId;
  final int id;
  final String title;
  final String body;

  PostData(this.userId, this.id, this.title, this.body);
}