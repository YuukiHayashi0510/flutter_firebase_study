import 'package:chat_firebase_app/pages/settings_profile.dart';
import 'package:chat_firebase_app/pages/talk_room.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  List<User> userList = [
    User(
        name: "Tanaka",
        id: "abc",
        imagePath: "https://pbs.twimg.com/media/E-hKe4WUcAcNlZA.jpg",
        lastMessage: "hello"),
    User(
        name: "Anno",
        id: "def",
        imagePath:
            "https://tmitter.news/wp/wp-content/uploads/2021/10/1634267023817.jpg",
        lastMessage: "aaaa!!!"),
    User(
        name: "りんりん",
        id: "def",
        imagePath:
            "https://demonition.com/wp/wp-content/uploads/2021/07/58211cf62c8da9e73c8b6b2c454c0b51.jpg",
        lastMessage: "シエル先輩!!!"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("チャットアプリ"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsProfilePage()));
            },
          )
        ],
      ),
      body: ListView.builder(
          // listの表示数
          itemCount: userList.length,
          // 実際に表示
          itemBuilder: (context, index) {
            // index => 繰り返し変数
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TalkRoom(userList[index].name)));
              },
              child: Container(
                height: 70,
                child: Row(
                  children: [
                    Padding(
                      // 右左＝＞synmetoric(horizontal) , 上下=>synmetoric(vertical)
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(userList[index].imagePath),
                        radius: 26,
                      ),
                    ),
                    Column(
                      // 左詰め(横方向)
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // 縦方向
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          userList[index].name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          userList[index].lastMessage,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
