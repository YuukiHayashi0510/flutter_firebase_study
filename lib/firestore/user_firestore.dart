import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class UserFirestore {
  static final FirebaseFirestore _firebaseFirestoreInstance =
      FirebaseFirestore.instance;
  static final _userCollection = _firebaseFirestoreInstance.collection('user');

  static Future<void> createUser() async {
    try {
      await _userCollection.add({
        'name': 'ななし',
        'image_path':
            'https://tmitter.news/wp/wp-content/uploads/2021/10/1634267023817.jpg'
      });
      print("アカウント作成完了");
    } catch (e) {
      print("アカウント作成失敗 === $e");
    }
  }
}
