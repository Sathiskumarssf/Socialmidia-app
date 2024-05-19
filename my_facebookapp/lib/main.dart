import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:my_facebookapp/pages/Login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyB1zs8QDrMHzpwnmX2NFRzkdBsnD-rPAGU",
          authDomain: "myfacebook-7940e.firebaseapp.com",
          projectId: "myfacebook-7940e",
          storageBucket: "myfacebook-7940e.appspot.com",
          messagingSenderId: "192979528438",
          appId: "1:192979528438:web:bb121223cfb4b9592d9ad7",
        ),
      );
    } else {
      await Firebase.initializeApp();
    }

    runApp(
      DevicePreview(
        enabled: !kReleaseMode, // Enable it only in debug mode
        builder: (context) => MyApp(), // Wrap your app
      ),
    );
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: DevicePreview.appBuilder, // Add the builder
      useInheritedMediaQuery: true, // Required to make it work
      locale: DevicePreview.locale(context), // Add locale to support locale changes
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
       
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/home': (context) => MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Make sure the length matches the number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Top Navigation Bar'),
          backgroundColor: Colors.blue, // Set the background color here
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.people), text: 'Friends'),
              Tab(icon: Icon(Icons.video_call_rounded), text: 'Vedios'),
              Tab(icon: Icon(Icons.notifications), text: 'Notif'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomeTab(),
            FriendsTab(),
            VediosTab(),
            NotifTab(),
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
                CollectionReference collRef = FirebaseFirestore.instance.collection('client');

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

class FriendsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Friends Page'),
    );
  }
}

class VediosTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Vedios Page'),
    );
  }
}

class NotifTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Notifications Page'),
    );
  }
}
