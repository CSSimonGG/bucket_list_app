import 'package:bucket_list_app/pages/bucket_list_page.dart';
import 'package:bucket_list_app/pages/completed_page.dart';
import 'package:bucket_list_app/pages/ideas_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

void main() async {
  // Init Hive
  await Hive.initFlutter();

  // open a box
  var box = await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Page index number
  int _selectedIndex = 0;

  // Update selected index
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    // Bucket list page
    BucketListPage(),

    // Ideas page
    IdeasPage(),

    // Completed page
    CompletedPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _pages[_selectedIndex],
        // Bottom nav
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _navigateBottomBar,
          backgroundColor: Colors.green[500],
          selectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb),
              label: 'Ideas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check),
              label: 'Completed',
            ),
          ],
        ),
      ),
      theme: ThemeData(
        primarySwatch: Colors.green,
        backgroundColor: Colors.green[300],
      ),

      // Routes
      routes: {
        '/bucketlist': (context) => BucketListPage(),
        '/ideas': (context) => IdeasPage(),
        '/completed': (context) => CompletedPage(),
      },
    );
  }
}
