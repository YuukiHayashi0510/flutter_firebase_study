import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingsProfilePage extends StatefulWidget {
  const SettingsProfilePage({Key? key}) : super(key: key);

  @override
  State<SettingsProfilePage> createState() => _SettingsProfilePageState();
}

class _SettingsProfilePageState extends State<SettingsProfilePage> {
  File? image;
  final ImagePicker _picker = ImagePicker();

  Future<void> selectImage() async {
    PickedFile? pickedImage = await _picker.getImage(source: ImageSource.gallery);
    if (pickedImage == null) return;

    setState(() {
      image = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("設定ページ"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(width: 100, child: Text("名前")),
                Expanded(child: TextField())
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                const SizedBox(width: 150.0, child: Text("プロフィール画像")),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Container(
                        width: 150,
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () {
                              selectImage();
                            },
                            child: Text("画像選択"))),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30.0),
            image == null
                ? SizedBox(
                    height: 150.0,
                  )
                : SizedBox(
                    width: 200, height: 200, child: Image.file(image!, fit: BoxFit.cover,)),
            const SizedBox(height: 30.0),
            SizedBox(
              width: 150.0,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("編集"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
