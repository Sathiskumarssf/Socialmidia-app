import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 
import 'Friends.dart';
import 'Upload.dart';
import 'Vidios.dart';
import 'Notification.dart';
import 'Home.dart';
 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Make sure the length matches the number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('HomeTown'),
          backgroundColor: Colors.blue, // Set the background color here
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.people), text: 'Friends'),
              Tab(icon: Icon(Icons.video_call_rounded), text: 'Vedios'),
              Tab(icon: Icon(Icons.notifications), text: 'Notif'),
              Tab(icon: Icon(Icons.add_a_photo),  text: 'Add ',),
              
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomeTab(),
            FriendsTab(),
            VediosTab(),
            NotifTab(),
            UploadTab()
          ],
        ),
      ),
    );
  }
}
 

 
 

 
