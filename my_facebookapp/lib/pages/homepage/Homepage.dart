import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 
import 'Friends.dart';
import 'Upload.dart';
import 'Vidios.dart';
import 'Notification.dart';
 

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

class HomeTab extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(hintText: 'Name'),
          ),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(hintText: 'Email'),
          ),
          TextFormField(
            controller: mobileController,
            decoration: const InputDecoration(hintText: 'Mobile'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              try {
                CollectionReference collRef =
                    FirebaseFirestore.instance.collection('client');

                await collRef.add({
                  'name': nameController.text,
                  'email': emailController.text,
                  'mobile': mobileController.text,
                });

                // Show a confirmation message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Client added successfully')),
                );
              } catch (e) {
                // Handle any errors
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to add client: $e')),
                );
              }
            },
            child: Text("Add Client"),
          ),
        ],
      ),
    );
  }
}

 
 

 
