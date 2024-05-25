 

import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
 
class UploadTab extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadTab> {
  final TextEditingController _textController = TextEditingController();
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  ImagePicker picker = ImagePicker();
  XFile? _imageFile;
  String? _imageUrl;

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
    if (kIsWeb && _imageFile != null) {
      _imageUrl = _imageFile!.path;
    }
  }

  Future<String> uploadImage(XFile imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageRef = storage.ref().child('uploads/$fileName');
    UploadTask uploadTask;

    if (kIsWeb) {
      uploadTask = storageRef.putData(await imageFile.readAsBytes());
    } else {
      uploadTask = storageRef.putFile(File(imageFile.path));
    }

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    return await taskSnapshot.ref.getDownloadURL();
  }

  Future<void> uploadData() async {
    if (_imageFile == null || _textController.text.isEmpty) {
      // Handle empty image or text
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image and enter text')),
      );
      return;
    }

    String imageUrl = await uploadImage(_imageFile!);
    CollectionReference uploads = firestore.collection('uploads');

    await uploads.add({
      'imageUrl': imageUrl,
      'text': _textController.text,
      'timestamp': DateTime.now(), // Optional: Add timestamp
    });

    print(imageUrl);
    setState(() {
      _imageFile = null;
      _imageUrl = null;
      _textController.text = '';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Upload successful')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adding your States'),
        backgroundColor: Colors.grey,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200.0,
              child: _imageFile != null
                  ? kIsWeb
                      ? Image.network(
                          _imageUrl!,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(_imageFile!.path),
                          fit: BoxFit.cover,
                        )
                  : Image.asset(
                      'assets/image1.png', // Placeholder image
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: pickImage,
              child: Text('Select image'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Heading',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: uploadData,
              child: Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
