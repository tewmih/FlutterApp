class UserModel {
  String uid;
  String firstName;
  String lastName;
  String email;
  String dormNumber;
  String department;
  int year;
  int semester;

  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dormNumber,
    required this.department,
    required this.year,
    required this.semester,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'dormNumber': dormNumber,
      'department': department,
      'year': year,
      'semester': semester,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      dormNumber: map['dormNumber'],
      department: map['department'],
      year: map['year'],
      semester: map['semester'],
    );
  }
}
