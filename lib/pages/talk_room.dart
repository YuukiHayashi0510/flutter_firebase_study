import 'package:chat_firebase_app/firestore/room_firestore.dart';
import 'package:chat_firebase_app/utils/shared_prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../model/message.dart';
import '../model/talk_room.dart';

class TalkRoomPage extends StatefulWidget {
  final TalkRoom talkRoom;

  TalkRoomPage(this.talkRoom);

  @override
  State<TalkRoomPage> createState() => _TalkRoomPageState();
}

class _TalkRoomPageState extends State<TalkRoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        // widget. 元のclassの値にアクセス
        title: Text(widget.talkRoom.talkUser.name),
      ),
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream:
                  RoomFirestore.fetchMessageSnapshot(widget.talkRoom.roomId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  dynamic snapshotData = snapshot.data!;
                  return Padding(
                    padding: EdgeInsets.only(bottom: 60),
                    child: ListView.builder(
                        // not scrollable, but when elements is over viewport, then scrollable
                        physics: RangeMaintainingScrollPhysics(),
                        // 要素が多くても縮小, scrollable
                        shrinkWrap: true,
                        // 下から表示
                        reverse: true,
                        itemCount: snapshotData.docs.length,
                        itemBuilder: (context, index) {
                          final doc = snapshotData.docs[index];
                          final Map<String, dynamic> data =
                              doc.data() as Map<String, dynamic>;
                          Message message = Message(
                              message: data['message'],
                              isMe: SharedPrefs.fetchUid() == data['sender_id'],
                              sendTime: data['send_time']);
                          return Padding(
                            padding: EdgeInsets.only(
                                top: 10.0,
                                right: 10.0,
                                left: 10.0,
                                bottom: index == 0 ? 10 : 0),
                            child: Row(
                              // 行に対するCross:縦
                              crossAxisAlignment: CrossAxisAlignment.end,
                              textDirection: message.isMe
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              children: [
                                Container(
                                    // 表示する幅を設定
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.5),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 6.0),
                                    decoration: BoxDecoration(
                                        // 三項演算子
                                        color: message.isMe
                                            ? Colors.green
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: Text(message.message)),
                                Text(
                                  intl.DateFormat('HH:mm')
                                      .format(message.sendTime.toDate()),
                                  style: TextStyle(fontSize: 10.0),
                                ),
                              ],
                            ),
                          );
                        }),
                  );
                } else {
                  return const Center(child: Text("メッセージがありません"));
                }
              }),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 60,
                color: Colors.white,
                child: Row(
                  children: [
                    // 幅の限界まで広げる
                    const Expanded(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    )),
                    IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          print("send");
                        }),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
