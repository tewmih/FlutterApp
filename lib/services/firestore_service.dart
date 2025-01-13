import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUser(UserModel user) async {
    try {
      await _db.collection('users').doc(user.uid).set(user.toMap());
      Fluttertoast.showToast(msg: "User Data Stored Successfully");
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
    }
  }

  Future<UserModel?> getUser(String uid) async {
    try {
      DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      Fluttertoast.showToast(msg: "No User Found");
      return null;
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
      return null;
    }
  }

  Future<List<String>> getCourses(String department, int year, int semester) async {
    QuerySnapshot querySnapshot = await _db.collection('courses')
        .where('department', isEqualTo: department)
        .where('year', isEqualTo: year)
        .where('semester', isEqualTo: semester)
        .get();
    return querySnapshot.docs.map((doc) => doc['courseName'] as String).toList();
  }
}
