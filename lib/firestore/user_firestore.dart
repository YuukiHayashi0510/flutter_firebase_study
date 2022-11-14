import 'package:chat_firebase_app/firestore/room_firestore.dart';
import 'package:chat_firebase_app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/shared_prefs.dart';

class UserFirestore {
  static final FirebaseFirestore _firebaseFirestoreInstance =
      FirebaseFirestore.instance;
  static final _userCollection = _firebaseFirestoreInstance.collection('user');

  static Future<String?> insertNewAccount() async {
    try {
      final newDoc = await _userCollection.add({
        'name': 'ななし',
        'image_path':
            'https://tmitter.news/wp/wp-content/uploads/2021/10/1634267023817.jpg'
      });
      print("アカウント作成完了");
      return newDoc.id;
    } catch (e) {
      print("アカウント作成失敗 === $e");
      return null;
    }
  }

  static Future<List<QueryDocumentSnapshot>?> fetchUsers() async {
    try {
      final snapshot = await _userCollection.get();
      return snapshot.docs;
    } catch (e) {
      print("ユーザ情報の取得失敗===$e");
    }
  }

  static Future<void> createUser() async {
    final myUid = await insertNewAccount();
    if (myUid != null) {
      RoomFirestore.createRoom(myUid);
      SharedPrefs.setUid(myUid);
    }
  }

  static Future<User?> fetchProfile(String uid) async {
    try {
      final snapshot = await _userCollection.doc(uid).get();
      User user = User(
          name: snapshot.data()!['name'],
          imagePath: snapshot.data()!['image_path'],
          id: uid);
      return user;
    } catch (e) {
      print("自分のユーザ情報取得失敗===$e");
      return null;
    }
  }
}
