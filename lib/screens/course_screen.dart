import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore_service.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  Future<List<String>> getAssignedCourses() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirestoreService _firestoreService = FirestoreService();
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      String department = userDoc['department'];
      int year = userDoc['year'];
      int semester = userDoc['semester'];
      return await _firestoreService.getCourses(department, year, semester);
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assigned Courses'),
        backgroundColor: Color(0xff072227),
      ),
      body: Center(
        child: FutureBuilder<List<String>>(
          future: getAssignedCourses(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            List<String> courses = snapshot.data!;
            return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(courses[index]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
