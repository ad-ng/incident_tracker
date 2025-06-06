import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:incident_tracker/features/home/presentation/pages/home_page.dart';
import 'package:incident_tracker/features/home/domain/usercases/add_incident_dialog.dart';
import 'package:incident_tracker/features/profile/presentation/pages/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int currentIndex = 0;

  List pages = [
    HomePage(),
    ProfilePage(),
    Center(child: Text(' S E T T I N G S')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Incident tracker'),
        actions: [
          IconButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              context.goNamed('login');
            },
            icon: Icon(Icons.logout_outlined, size: 35),
          ),
        ],
      ),
      body: pages[currentIndex],
      floatingActionButton:
          (currentIndex == 0)
              ? FloatingActionButton(
                onPressed: () {
                  TextEditingController titleController =
                      TextEditingController();
                  TextEditingController descriptionController =
                      TextEditingController();
                  TextEditingController locationController =
                      TextEditingController();
                  TextEditingController dateController =
                      TextEditingController();
                  return openModel(
                    context,
                    titleController,
                    descriptionController,
                    locationController,
                    dateController,
                    'Add a New Incident',
                    'Save',
                    'Priority',
                    'Open',
                    '',
                  );
                },
                child: Icon(Icons.add),
              )
              : SizedBox.shrink(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
      ),
    );
  }
}
