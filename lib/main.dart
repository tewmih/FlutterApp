import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_registration/firebase_options.dart';
import 'package:student_registration/screens/course_screen.dart';
import 'package:student_registration/screens/home_screen.dart';
import 'package:student_registration/screens/layout.dart';
import 'package:student_registration/screens/login_screen.dart';
import 'package:student_registration/screens/news_screen.dart';
import 'package:student_registration/screens/profile_screen.dart';
import 'package:student_registration/screens/registration_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Registration App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: user == null ? LoginScreen() : const AppLayout(child: HomeScreen()),
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => const AppLayout(child: HomeScreen()),
        '/courses': (context) => const AppLayout(child: CoursesScreen()),
        '/news': (context) => const AppLayout(child: NewsScreen()),
        '/profile': (context) => const AppLayout(child: ProfileScreen()),
        '/registration': (context) => const RegistrationScreen(),
      },
    );
  }
}
