import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incident_tracker/features/home/data/models/incident_model.dart';
import 'package:incident_tracker/features/home/presentation/bloc/incidents_cubit.dart';
import 'package:uuid/uuid.dart';

void openModel(
  BuildContext context,
  TextEditingController titleController,
  TextEditingController descriptionController,
  TextEditingController locationController,
  TextEditingController dateController,
  String modelTitle,
  String actionName,
  String categoryDropDownValue,
  String statusDropDownValue,
  String? uuidNew,
) {
  showDialog(
    context: context,
    builder: (context) {
      List<String> categoryItems = [
        'High priority',
        'Priority',
        'Low Priority',
      ];

      List<String> statusItems = ['Open', 'Closed'];

      return AlertDialog(
        title: Text(modelTitle),
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
                              value: categoryDropDownValue,
                              items:
                                  categoryItems.map((String item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                              onChanged: (String? newValue) {
                                setModalState(() {
                                  categoryDropDownValue = newValue!;
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
                              value: statusDropDownValue,
                              items:
                                  statusItems.map((String item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                              onChanged: (String? newValue) {
                                setModalState(() {
                                  statusDropDownValue = newValue!;
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
            onPressed: () async {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final uuid = const Uuid();
              final incident = IncidentModel(
                uuid: (actionName == 'Save') ? uuid.v1() : uuidNew!,
                title: titleController.text,
                description: descriptionController.text,
                category: categoryDropDownValue,
                Location: locationController.text,
                dateTime: dateController.text,
                status: statusDropDownValue,
                photo: 'testing',
              );

              try {
                if (actionName == 'Save') {
                  await context.read<IncidentCubit>().addIncident(incident);
                } else {
                  await context.read<IncidentCubit>().updateIncident(
                    uuidNew!,
                    incident,
                  );
                }

                Navigator.pop(context);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Something went wrong: $e')),
                );
              }
            },
            child: Text(actionName),
          ),
        ],
      );
    },
  );
}
