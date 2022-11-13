import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class UserFirestore {
  static final FirebaseFirestore _firebaseFirestoreInstance =
      FirebaseFirestore.instance;
  static final _userCollection = _firebaseFirestoreInstance.collection('user');

  static Future<String?> createUser() async {
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
}
