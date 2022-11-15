import 'dart:io';
import 'package:chat_firebase_app/firestore/user_firestore.dart';
import 'package:chat_firebase_app/model/user.dart';
import 'package:chat_firebase_app/utils/shared_prefs.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingsProfilePage extends StatefulWidget {
  const SettingsProfilePage({Key? key}) : super(key: key);

  @override
  State<SettingsProfilePage> createState() => _SettingsProfilePageState();
}

class _SettingsProfilePageState extends State<SettingsProfilePage> {
  File? image;
  String imagePath = '';
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _controller = TextEditingController();

  Future<void> selectImage() async {
    PickedFile? pickedImage =
        await _picker.getImage(source: ImageSource.gallery);
    if (pickedImage == null) return;

    setState(() {
      image = File(pickedImage.path);
    });
  }

  Future<void> uploadImage() async {
    String path = image!.path.substring(image!.path.lastIndexOf('/') + 1);
    final ref = FirebaseStorage.instance.ref('${path}.png');
    final storedImage = await ref.putFile(image!);
    imagePath = await storedImage.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("設定ページ"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 100, child: Text("名前")),
                Expanded(
                    child: TextField(
                  controller: _controller,
                ))
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                const SizedBox(width: 150.0, child: Text("プロフィール画像")),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: SizedBox(
                        width: 150,
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () async {
                              await selectImage();
                            },
                            child: const Text("画像選択"))),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30.0),
            image == null
                ? const SizedBox(
                    height: 150.0,
                  )
                : SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.file(
                      image!,
                      fit: BoxFit.cover,
                    )),
            const SizedBox(height: 30.0),
            SizedBox(
              width: 150.0,
              child: ElevatedButton(
                onPressed: () async {
                  await uploadImage();
                  User newProfile = User(
                      name: _controller.text,
                      imagePath: imagePath,
                      id: SharedPrefs.fetchUid()!);
                  await UserFirestore.updateUser(newProfile);
                },
                child: Text("編集"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
