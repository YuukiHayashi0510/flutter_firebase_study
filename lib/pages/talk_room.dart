import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../model/message.dart';

class TalkRoom extends StatefulWidget {
  final String name;

  TalkRoom(this.name);

  @override
  State<TalkRoom> createState() => _TalkRoomState();
}

class _TalkRoomState extends State<TalkRoom> {
  List<Message> messageList = [
    Message(
        message: "aaaacccascascascasdcdcdsacasdcdvcdsvsdvsdvsd",
        isMe: true,
        sendTime: DateTime(2022, 1, 1, 10, 20)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        // widget. 元のclassの値にアクセス
        title: Text(widget.name),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 60),
            child: ListView.builder(
                // not scrollable, but when elements is over viewport, then scrollable
                physics: RangeMaintainingScrollPhysics(),
                // 要素が多くても縮小, scrollable
                shrinkWrap: true,
                // 下から表示
                reverse: true,
                itemCount: messageList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: 10.0,
                        right: 10.0,
                        left: 10.0,
                        bottom: index == 0 ? 10 : 0),
                    child: Row(
                      // 行に対するCross:縦
                      crossAxisAlignment: CrossAxisAlignment.end,
                      textDirection: messageList[index].isMe
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      children: [
                        Container(
                            // 表示する幅を設定
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.5),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 6.0),
                            decoration: BoxDecoration(
                                // 三項演算子
                                color: messageList[index].isMe
                                    ? Colors.green
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Text(messageList[index].message)),
                        Text(
                          intl.DateFormat('HH:mm')
                              .format(messageList[index].sendTime),
                          style: TextStyle(fontSize: 10.0),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              color: Colors.white,
              child: Row(
                children: [
                  // 幅の限界まで広げる
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
          )
        ],
      ),
    );
  }
}
