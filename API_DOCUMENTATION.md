# Student Registration App - API Documentation

## Overview

The Student Registration App is a Flutter application designed for Addis Ababa Science and Technology University (AASTU) students. It provides authentication, user registration, profile management, and course assignment functionality using Firebase as the backend.

## Table of Contents

1. [Project Structure](#project-structure)
2. [Models](#models)
3. [Services](#services)
4. [Screens/Components](#screenscomponents)
5. [Configuration](#configuration)
6. [Installation & Setup](#installation--setup)
7. [Usage Examples](#usage-examples)

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── firebase_options.dart     # Firebase configuration
├── models/
│   └── user_model.dart      # User data model
├── services/
│   ├── auth_service.dart    # Authentication service
│   └── firestore_service.dart # Database service
└── screens/
    ├── home_screen.dart     # Home screen component
    ├── login_screen.dart    # Login screen component
    ├── registration_screen.dart # Registration screen component
    ├── profile_screen.dart  # Profile screen component
    ├── course_screen.dart   # Course listing screen
    ├── news_screen.dart     # News screen component
    ├── layout.dart          # App layout wrapper
    └── splash_screen.dart   # Splash screen component
```

## Models

### UserModel

A data model representing a student user.

**Location:** `lib/models/user_model.dart`

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `uid` | `String` | Unique Firebase user ID |
| `firstName` | `String` | Student's first name |
| `lastName` | `String` | Student's last name |
| `email` | `String` | Student's email address |
| `dormNumber` | `String` | Student's dormitory number |
| `department` | `String` | Student's academic department |
| `year` | `int` | Student's academic year |
| `semester` | `int` | Student's current semester |

#### Constructor

```dart
UserModel({
  required String uid,
  required String firstName,
  required String lastName,
  required String email,
  required String dormNumber,
  required String department,
  required int year,
  required int semester,
})
```

#### Methods

##### `toMap()`
Converts the UserModel instance to a Map for Firebase storage.

**Returns:** `Map<String, dynamic>`

**Example:**
```dart
UserModel user = UserModel(
  uid: "user123",
  firstName: "John",
  lastName: "Doe",
  email: "john.doe@example.com",
  dormNumber: "A101",
  department: "Computer Science",
  year: 3,
  semester: 1,
);
Map<String, dynamic> userMap = user.toMap();
```

##### `fromMap(Map<String, dynamic> map)`
Factory constructor that creates a UserModel from a Map.

**Parameters:**
- `map`: Map containing user data

**Returns:** `UserModel`

**Example:**
```dart
Map<String, dynamic> userData = {
  'uid': 'user123',
  'firstName': 'John',
  'lastName': 'Doe',
  'email': 'john.doe@example.com',
  'dormNumber': 'A101',
  'department': 'Computer Science',
  'year': 3,
  'semester': 1,
};
UserModel user = UserModel.fromMap(userData);
```

## Services

### AuthService

Handles user authentication operations using Firebase Auth.

**Location:** `lib/services/auth_service.dart`

#### Methods

##### `signInWithEmail(String email, String password)`
Authenticates a user with email and password.

**Parameters:**
- `email`: User's email address
- `password`: User's password

**Returns:** `Future<User?>` - Firebase User object if successful, null if failed

**Example:**
```dart
AuthService authService = AuthService();
User? user = await authService.signInWithEmail("john@example.com", "password123");
if (user != null) {
  print("Login successful: ${user.email}");
} else {
  print("Login failed");
}
```

##### `registerWithEmail(String email, String password)`
Creates a new user account with email and password.

**Parameters:**
- `email`: User's email address
- `password`: User's password

**Returns:** `Future<User?>` - Firebase User object if successful, null if failed

**Example:**
```dart
AuthService authService = AuthService();
User? user = await authService.registerWithEmail("john@example.com", "password123");
if (user != null) {
  print("Registration successful: ${user.email}");
}
```

##### `signOut()`
Signs out the current user.

**Returns:** `Future<void>`

**Example:**
```dart
AuthService authService = AuthService();
await authService.signOut();
```

##### `getCurrentUser()`
Gets the currently authenticated user.

**Returns:** `User?` - Current Firebase User or null if not authenticated

**Example:**
```dart
AuthService authService = AuthService();
User? currentUser = authService.getCurrentUser();
if (currentUser != null) {
  print("Current user: ${currentUser.email}");
}
```

##### `signInWithGoogle()`
Authenticates a user using Google Sign-In.

**Returns:** `Future<User?>` - Firebase User object if successful, null if failed

**Example:**
```dart
AuthService authService = AuthService();
User? user = await authService.signInWithGoogle();
if (user != null) {
  print("Google sign-in successful: ${user.email}");
}
```

### FirestoreService

Handles database operations using Cloud Firestore.

**Location:** `lib/services/firestore_service.dart`

#### Methods

##### `addUser(UserModel user)`
Stores user data in Firestore.

**Parameters:**
- `user`: UserModel instance to store

**Returns:** `Future<void>`

**Example:**
```dart
FirestoreService firestoreService = FirestoreService();
UserModel user = UserModel(
  uid: "user123",
  firstName: "John",
  lastName: "Doe",
  email: "john@example.com",
  dormNumber: "A101",
  department: "Computer Science",
  year: 3,
  semester: 1,
);
await firestoreService.addUser(user);
```

##### `getUser(String uid)`
Retrieves user data from Firestore.

**Parameters:**
- `uid`: User's unique identifier

**Returns:** `Future<UserModel?>` - UserModel if found, null if not found

**Example:**
```dart
FirestoreService firestoreService = FirestoreService();
UserModel? user = await firestoreService.getUser("user123");
if (user != null) {
  print("User found: ${user.firstName} ${user.lastName}");
}
```

##### `getCourses(String department, int year, int semester)`
Retrieves courses assigned to a specific department, year, and semester.

**Parameters:**
- `department`: Student's department
- `year`: Academic year
- `semester`: Academic semester

**Returns:** `Future<List<String>>` - List of course names

**Example:**
```dart
FirestoreService firestoreService = FirestoreService();
List<String> courses = await firestoreService.getCourses("Computer Science", 3, 1);
for (String course in courses) {
  print("Course: $course");
}
```

## Screens/Components

### MyApp

The main application widget that sets up routing and Firebase initialization.

**Location:** `lib/main.dart`

#### Properties

- Extends `StatefulWidget`
- Manages user authentication state
- Defines app routes and navigation

#### Routes

| Route | Component | Description |
|-------|-----------|-------------|
| `/` | `LoginScreen` or `HomeScreen` | Default route based on auth state |
| `/login` | `LoginScreen` | User login page |
| `/home` | `HomeScreen` | App home page |
| `/courses` | `CoursesScreen` | Course listing page |
| `/news` | `NewsScreen` | News page |
| `/profile` | `ProfileScreen` | User profile page |
| `/registration` | `RegistrationScreen` | User registration page |

### LoginScreen

User authentication screen with email/password and Google Sign-In options.

**Location:** `lib/screens/login_screen.dart`

#### Features

- Email/password authentication
- Google Sign-In integration
- Form validation
- Navigation to registration screen
- Error handling with dialogs

#### Methods

##### `signIn(String email, String password)`
Handles email/password login process.

**Parameters:**
- `email`: User's email
- `password`: User's password

**Example Usage:**
```dart
// The LoginScreen handles this internally
// Users interact through the UI form
```

##### `signInWithGoogle()`
Handles Google Sign-In authentication.

**Example Usage:**
```dart
// Triggered when user taps Google Sign-In button
// Automatically redirects to home screen on success
```

### RegistrationScreen

User registration screen for creating new accounts.

**Location:** `lib/screens/registration_screen.dart`

#### Features

- Multi-field registration form
- Form validation
- User data collection (name, email, dorm, department, etc.)
- Password confirmation
- Integration with AuthService and FirestoreService

#### Form Fields

| Field | Type | Validation | Description |
|-------|------|------------|-------------|
| `firstName` | `String` | Required, min 3 chars | Student's first name |
| `lastName` | `String` | Required | Student's last name |
| `email` | `String` | Required, valid email | Student's email |
| `password` | `String` | Required, min 6 chars | User's password |
| `confirmPassword` | `String` | Must match password | Password confirmation |
| `dormNumber` | `String` | Required | Dormitory number |
| `department` | `String` | Required | Academic department |
| `year` | `int` | Required | Academic year |
| `semester` | `int` | Required | Current semester |

#### Methods

##### `signUp(String email, String password)`
Handles the registration process.

**Parameters:**
- `email`: User's email
- `password`: User's password

### AppLayout

Application layout wrapper providing navigation and sidebar functionality.

**Location:** `lib/screens/layout.dart`

#### Features

- Collapsible sidebar navigation
- Bottom navigation bar
- App bar with university branding
- Logout functionality

#### Properties

- `child`: Widget to display in the main content area
- `isSidebarOpen`: Boolean controlling sidebar visibility

#### Navigation Items

| Item | Icon | Route | Description |
|------|------|-------|-------------|
| Home | `Icons.home` | `/home` | Navigate to home screen |
| Courses | `Icons.school` | `/courses` | Navigate to courses screen |
| News | `Icons.article` | `/news` | Navigate to news screen |
| Profile | `Icons.person` | `/profile` | Navigate to profile screen |
| Logout | `Icons.exit_to_app` | - | Sign out user |

### HomeScreen

Welcome screen with university information and navigation.

**Location:** `lib/screens/home_screen.dart`

#### Features

- University background image
- Welcome message
- Navigation to course registration
- Responsive design

### ProfileScreen

User profile display with personal information and assigned courses.

**Location:** `lib/screens/profile_screen.dart`

#### Features

- Display user information
- List assigned courses
- Real-time data from Firestore

#### Methods

##### `getUserData()`
Retrieves current user's profile data.

**Returns:** `Future<Map<String, dynamic>>`

##### `getCourses()`
Retrieves courses assigned to the current user.

**Returns:** `Future<List<String>>`

### CoursesScreen

Display of courses assigned to the current user.

**Location:** `lib/screens/course_screen.dart`

#### Features

- List of assigned courses
- Course filtering by department, year, and semester
- Loading states

#### Methods

##### `getAssignedCourses()`
Retrieves courses for the current user.

**Returns:** `Future<List<String>>`

### NewsScreen

Basic news display screen (placeholder implementation).

**Location:** `lib/screens/news_screen.dart`

#### Features

- Simple text display
- Placeholder for future news functionality

## Configuration

### Firebase Configuration

**Location:** `lib/firebase_options.dart`

#### DefaultFirebaseOptions

Provides platform-specific Firebase configuration.

##### Properties

- `currentPlatform`: Returns appropriate FirebaseOptions for current platform
- `web`: Web platform configuration
- `android`: Android platform configuration

#### Supported Platforms

- ✅ Web
- ✅ Android
- ❌ iOS (not configured)
- ❌ macOS (not configured)
- ❌ Windows (not configured)
- ❌ Linux (not configured)

## Installation & Setup

### Prerequisites

- Flutter SDK (^3.5.4)
- Firebase project with Authentication and Firestore enabled
- Google Sign-In configuration

### Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  firebase_auth: ^5.3.4
  firebase_core: ^3.9.0
  fluttertoast: ^8.2.10
  cloud_firestore: ^5.6.0
  google_sign_in: ^5.4.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0
```

### Setup Steps

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd student_registration
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase:**
   - Create a Firebase project
   - Enable Authentication (Email/Password and Google)
   - Enable Cloud Firestore
   - Add your Firebase configuration to `lib/firebase_options.dart`

4. **Add assets:**
   - Place image assets in `assets/images/` directory
   - Update `pubspec.yaml` with asset paths

5. **Run the app:**
   ```bash
   flutter run
   ```

## Usage Examples

### Complete Registration Flow

```dart
// 1. User opens app and sees LoginScreen
// 2. User taps "Sign up" to go to RegistrationScreen
// 3. User fills out the registration form
// 4. User taps "Sign up" button

void signUp(String email, String password) async {
  if (_formKey.currentState!.validate()) {
    User? user = await _authService.registerWithEmail(email, password);
    if (user != null) {
      UserModel userModel = UserModel(
        uid: user.uid,
        email: email,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        dormNumber: dormNumberController.text,
        department: departmentController.text,
        year: int.parse(yearController.text),
        semester: int.parse(semesterController.text),
      );
      await _firestoreService.addUser(userModel);
      // Navigate to login screen
    }
  }
}
```

### Login Flow

```dart
// 1. User enters email and password
// 2. User taps "Login" button

void signIn(String email, String password) async {
  if (_formKey.currentState!.validate()) {
    User? user = await _authService.signInWithEmail(email, password);
    if (user != null) {
      // Navigate to home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AppLayout(child: HomeScreen()),
        ),
      );
    }
  }
}
```

### Fetching User Profile

```dart
// Display user profile information
FutureBuilder<Map<String, dynamic>>(
  future: getUserData(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) {
      return const Center(child: CircularProgressIndicator());
    }
    Map<String, dynamic> userData = snapshot.data!;
    return Column(
      children: [
        Text('Name: ${userData['firstName']} ${userData['lastName']}'),
        Text('Email: ${userData['email']}'),
        Text('Department: ${userData['department']}'),
        // More fields...
      ],
    );
  },
)
```

### Course Management

```dart
// Fetch and display courses
Future<List<String>> getCourses() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    FirestoreService _firestoreService = FirestoreService();
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    String department = userDoc['department'];
    int year = userDoc['year'];
    int semester = userDoc['semester'];
    return await _firestoreService.getCourses(department, year, semester);
  }
  return [];
}
```

## Error Handling

The app includes comprehensive error handling:

- **Authentication errors**: Displayed via Flutter toast messages
- **Network errors**: Handled gracefully with loading states
- **Form validation**: Real-time validation with error messages
- **Database errors**: Logged to console and shown to user via toast

## Security Considerations

- Passwords are handled securely through Firebase Auth
- User data is stored in Firestore with proper access rules
- Google Sign-In integration follows OAuth 2.0 standards
- No sensitive data is stored locally

## Future Enhancements

- Push notifications for course updates
- File upload functionality
- Advanced course scheduling
- Student messaging system
- Grade tracking
- Offline capability

---

**Note:** This documentation covers the current implementation. Some features like the News screen are placeholder implementations that can be expanded based on requirements.