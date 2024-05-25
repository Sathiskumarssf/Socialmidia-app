import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:my_facebookapp/pages/Login.dart';
 
import 'package:my_facebookapp/pages/homepage/Homepage.dart';

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
      locale:
          DevicePreview.locale(context), // Add locale to support locale changes
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
