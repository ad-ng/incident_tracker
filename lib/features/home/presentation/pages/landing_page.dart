import 'package:flutter/material.dart';
import 'package:incident_tracker/features/home/presentation/pages/home_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int currentIndex = 0;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  List pages = [
    HomePage(),
    Center(child: Text(' P R O F I L E')),
    Center(child: Text(' S E T T I N G S')),
  ];

  void openModel() {
    showDialog(
      context: context,
      builder: (context) {
        String _categoryDropDownValue = 'High priority';
        List<String> categoryItems = [
          'High priority',
          'Priority',
          'Low Priority',
        ];

        String _statusDropDownValue = 'Open';
        List<String> statusItems = ['Open', 'Closed'];

        return AlertDialog(
          title: Text('Add a New Incident'),
          content: Container(
            height: 380,
            child: Form(
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: titleController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(),
                            labelText: 'Title',
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: descriptionController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(),
                            labelText: 'Description',
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: locationController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(),
                            labelText: 'Location',
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: dateController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(),
                            labelText: 'Date & Time',
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text("Category:", style: TextStyle(fontSize: 16)),
                            SizedBox(width: 12),
                            Expanded(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: _categoryDropDownValue,
                                items:
                                    categoryItems.map((String item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                onChanged: (String? newValue) {
                                  setModalState(() {
                                    _categoryDropDownValue = newValue!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Status:   ", style: TextStyle(fontSize: 16)),
                            SizedBox(width: 12),
                            Expanded(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: _statusDropDownValue,
                                items:
                                    statusItems.map((String item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                onChanged: (String? newValue) {
                                  setModalState(() {
                                    _statusDropDownValue = newValue!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Incident tracker'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.logout_outlined, size: 35),
          ),
        ],
      ),
      body: pages[currentIndex],
      floatingActionButton:
          (currentIndex == 0)
              ? FloatingActionButton(
                onPressed: openModel,
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
