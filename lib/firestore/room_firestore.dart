import 'package:chat_firebase_app/firestore/user_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomFirestore {
  static final FirebaseFirestore _firebaseFirestoreInstance =
      FirebaseFirestore.instance;
  static final _roomCollection = _firebaseFirestoreInstance.collection('room');

  static Future<void> createRoom(String myUid) async {
    try {
      final docs = await UserFirestore.fetchUsers();
      if (docs == null) return;
      docs.forEach((doc) async {
        if (doc.id == myUid) return;
        await _roomCollection.add({
          'joined_user_id': [doc.id, myUid],
          'created_time': Timestamp.now()
        });
      });
    } catch (e) {
      print("ルーム作成失敗===$e");
    }
  }
}
