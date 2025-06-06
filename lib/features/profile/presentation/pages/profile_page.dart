import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:incident_tracker/features/auth/data/datasources/local/userPreference.dart';
import 'package:incident_tracker/features/profile/data/datasources/remote/profileApiService.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: FutureBuilder<Uint8List?>(
            future: ProfileApiService().fetchProtectedImage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError || snapshot.data == null) {
                return Icon(Icons.error);
              } else {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(120),
                  child: Image.memory(snapshot.data!, height: 200, width: 200),
                );
              }
            },
          ),
        ),
        SizedBox(height: 10),
        FutureBuilder(
          future: UserPreferences().getLocalUser(),
          builder: (context, snapshot) {
            if (ConnectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Card(
                      color: Colors.blue[300],
                      child: ListTile(
                        leading: Icon(Icons.person_2, color: Colors.white),
                        title: Text(
                          'Names',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Text(
                          snapshot.data!.firstName! +
                              '  ' +
                              snapshot.data!.lastName!,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Card(
                      color: Colors.blue[300],
                      child: ListTile(
                        leading: Icon(Icons.man, color: Colors.white),
                        title: Text(
                          'Gender',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Text(
                          snapshot.data!.gender!,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Card(
                      color: Colors.blue[300],
                      child: ListTile(
                        leading: Icon(Icons.email, color: Colors.white),
                        title: Text(
                          'Email',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Text(
                          snapshot.data!.email!,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Card(
                      color: Colors.blue[300],
                      child: ListTile(
                        leading: Icon(Icons.phone, color: Colors.white),
                        title: Text(
                          'Phone',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Text(
                          snapshot.data!.phone!,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Card(
                      color: Colors.blue[300],
                      child: ListTile(
                        leading: Icon(Icons.lock_person, color: Colors.white),
                        title: Text(
                          'Account Type',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Text(
                          snapshot.data!.accountType!,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
