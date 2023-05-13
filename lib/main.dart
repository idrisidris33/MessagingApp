import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:messages_app/Auth/login.dart';
import 'package:messages_app/Auth/signup.dart';
import 'package:messages_app/simple.dart';
import 'authmethod.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDEpKbowqiTH9r0OsUJ_Zu0esZfIQslq38",
            appId: "1:390019431802:web:20e502b33ea8775b446ac3",
            messagingSenderId: "390019431802",
            projectId: "messegenow-c3244"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //  home: AuthMethod(),
     home: Simple(),
       );
  }
}   
     



