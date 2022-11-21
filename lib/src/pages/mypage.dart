import 'package:flutter/material.dart';
import 'package:movill/src/components/avatar_widget.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  Widget myAvatar() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          AvatarWidget(
              type: AvatarType.Type1,
              thumbPath:
                  'https://icons.veryicon.com/png/o/internet--web/prejudice/user-128.png')
        ],
      ),
    );
  }

  Widget information() {
    return Column(
      children: [
        Row(
          children: [
            myAvatar(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'OOO',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '+82 10-0000-0000',
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              width: 94,
            ),
            Container(
              child: IconButton(
                icon: Icon(Icons.add_circle),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget menu() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          SizedBox(
            height: 250,
          ),
          Column(
            children: [
              Row(
                children: [
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.access_time_outlined),
                      onPressed: () {},
                    ),
                  ),
                  Text(
                    '공지사항',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 236,
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.add_circle),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.add_chart),
                      onPressed: () {},
                    ),
                  ),
                  Text(
                    '차량관리',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 236,
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.add_circle),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '내 정보',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black87),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            information(),
            menu(),
          ],
        ),
      ),
    );
  }
}
