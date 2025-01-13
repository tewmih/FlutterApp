import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<Map<String, dynamic>> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      return userDoc.data() as Map<String, dynamic>;
    }
    return {};
  }

  Future<List<String>> getCourses() async {
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
        title: const Text('Profile'),
        backgroundColor: const Color(0xff072227),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          Map<String, dynamic> userData = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${userData['firstName']} ${userData['lastName']}', style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 10),
                Text('Email: ${userData['email']}', style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 10),
                Text('Dorm Number: ${userData['dormNumber']}', style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 10),
                Text('Department: ${userData['department']}', style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 10),
                Text('Year: ${userData['year']}', style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 10),
                Text('Semester: ${userData['semester']}', style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                const Text('Courses:', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Expanded(
                  child: FutureBuilder<List<String>>(
                    future: getCourses(),
                    builder: (context, courseSnapshot) {
                      if (!courseSnapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      List<String> courses = courseSnapshot.data!;
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
              ],
            ),
          );
        },
      ),
    );
  }
}
