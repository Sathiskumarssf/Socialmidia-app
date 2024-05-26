import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late List<String> _imageUrls;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    // Initialize Firebase Storage instance
    final storage = FirebaseStorage.instance;
    
    try {
      // Get a reference to the folder containing the images
      final ref = storage.ref().child('uploads');
      
      // Get the list of all items (images) in the folder
      final items = await ref.listAll();

      // Iterate through each item and construct the download URL
      _imageUrls = await Future.wait(
        items.items.map((item) async {
          return await item.getDownloadURL();
        }),
      );

      setState(() {
        _isLoading = false;
      });
    } on FirebaseException catch (e) {
      // Handle errors
      print('Error loading images: ${e.message}');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image List'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: _imageUrls.length,
                itemBuilder: (context, index) {
                  return Image.network(_imageUrls[index]);
                },
              ),
          ),
    );
  }
}
