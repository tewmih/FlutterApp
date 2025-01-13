import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'news_screen.dart';
import 'login_screen.dart';

class AppLayout extends StatefulWidget {
  final Widget child;

  const AppLayout({required this.child, super.key});

  @override
  _AppLayoutState createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  bool isSidebarOpen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff072227),
        title: const Text("Addis Ababa Science and Technology University",
            style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(isSidebarOpen ? Icons.menu_open : Icons.menu),
          color: Colors.white,
          onPressed: () {
            setState(() {
              isSidebarOpen = !isSidebarOpen;
            });
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          widget.child,
          if (isSidebarOpen)
            Container(
              width: 200,
              color: const Color(0xff072227).withOpacity(0.9),
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                    decoration: const BoxDecoration(color: Color(0xff072227)),
                    child: Column(
                      children: [
                        Image.asset("images/logo.png", height: 80),
                        const SizedBox(height: 10),
                        const Text(
                          'AASTU',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home,
                        color: Color.fromARGB(255, 250, 114, 2)),
                    title: const Text('Home',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.school,
                        color: Color.fromARGB(255, 250, 135, 3)),
                    title: const Text('Courses',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/courses');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.article,
                        color: Color.fromARGB(255, 250, 143, 4)),
                    title: const Text('News',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/news');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person,
                        color: Color.fromARGB(255, 242, 113, 7)),
                    title: const Text('Profile',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/profile');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app,
                        color: Color.fromARGB(255, 235, 138, 10)),
                    title: const Text('Logout',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      _logout(context);
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color.fromARGB(255, 64, 151, 195)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school, color: Color.fromARGB(255, 64, 151, 195)),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article, color: Color.fromARGB(255, 64, 151, 195)),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color.fromARGB(255, 64, 151, 195)),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app,
                color: Color.fromARGB(255, 64, 151, 195)),
            label: 'Logout',
          ),
        ],
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: const Color.fromARGB(255, 47, 158, 108),
        backgroundColor: const Color(0xff072227),
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/courses');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/news');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/profile');
              break;
            case 4:
              _logout(context);
              break;
          }
        },
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
}
