import 'package:chat_firebase_app/firestore/room_firestore.dart';
import 'package:chat_firebase_app/pages/settings_profile.dart';
import 'package:chat_firebase_app/pages/talk_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
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
      body: StreamBuilder<QuerySnapshot>(
          stream: RoomFirestore.joinedRoomSnapshot,
          builder: (context, streamSnapshot) {
            if (streamSnapshot.hasData) {
              // FutureBuilder<List<TalkRoom?>>ではfutureプロパティが変な解釈してバグる
              return FutureBuilder(
                  future: RoomFirestore.fetchJoinedRooms(streamSnapshot.data!),
                  builder: (context, futureSnapshot) {
                    if (futureSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (futureSnapshot.hasData) {
                        dynamic talkRooms = futureSnapshot.data;
                        return ListView.builder(
                            // listの表示数
                            itemCount: talkRooms.length,
                            // 実際に表示
                            itemBuilder: (context, index) {
                              // index => 繰り返し変数
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TalkRoomPage(talkRooms[index])));
                                },
                                child: SizedBox(
                                  height: 70,
                                  child: Row(
                                    children: [
                                      Padding(
                                        // 右左＝＞synmetoric(horizontal) , 上下=>synmetoric(vertical)
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          backgroundImage: talkRooms[index]
                                                      .talkUser
                                                      .imagePath ==
                                                  null
                                              ? null
                                              : NetworkImage(talkRooms[index]
                                                  .talkUser
                                                  .imagePath),
                                          radius: 26,
                                        ),
                                      ),
                                      Column(
                                        // 左詰め(横方向)
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // 縦方向
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            talkRooms[index].talkUser.name,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            talkRooms[index].lastMessage ?? '',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else {
                        return const Center(child: Text("トークルームの取得に失敗しました"));
                      }
                    }
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
