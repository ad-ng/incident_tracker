import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:incident_tracker/features/home/data/models/incident_model.dart';
import 'package:incident_tracker/features/home/presentation/bloc/incidents_cubit.dart';
import 'package:incident_tracker/features/home/presentation/widgets/myDateTimePicker.dart';
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
  String? currentPhoto,
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

      final _formKey = GlobalKey<FormState>();

      final ImagePicker picker = ImagePicker();
      String? photo;

      Future<void> pickImage() async {
        final XFile? pickedFile = await picker.pickImage(
          source: ImageSource.gallery,
        );

        if (pickedFile != null) {
          File imageFile = File(pickedFile.path);
          final bytes = await imageFile.readAsBytes();
          photo = base64Encode(bytes);
          currentPhoto = photo;
        }
      }

      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(modelTitle, style: TextStyle(color: Colors.blue[300])),
        content: Container(
          height: 400,
          child: Form(
            key: _formKey,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: titleController,
                        cursorColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          fillColor: Colors.blue.shade300,
                          filled: true,
                          labelText: 'Title',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Title is required';
                          } else if (value.trim().length < 3) {
                            return 'Title must be at least 3 characters';
                          } else if (value.trim().length > 25) {
                            return 'Title must be at most 25 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: descriptionController,
                        cursorColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          labelText: 'Description',
                          labelStyle: TextStyle(color: Colors.black),
                          fillColor: Colors.blue.shade300,
                          filled: true,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Description is required';
                          } else if (value.trim().length < 3) {
                            return 'Description must be at least 3 characters';
                          } else if (value.trim().length > 250) {
                            return 'Description must be at most 250 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: locationController,
                        cursorColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          labelText: 'Location',
                          labelStyle: TextStyle(color: Colors.black),
                          fillColor: Colors.blue.shade300,
                          filled: true,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Location is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 8),
                      MyDateTimePicker(dobController: dateController),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: pickImage,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue[300],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              'Select Image',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text("Category:", style: TextStyle(fontSize: 16)),
                          SizedBox(width: 12),
                          Expanded(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: categoryDropDownValue,
                              dropdownColor: Colors.blue[300],
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
                              dropdownColor: Colors.blue[300],
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
              if (actionName == 'Save') {
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                print('Form is valid!');
                final uuid = const Uuid();
                final incident = IncidentModel(
                  uuid: (actionName == 'Save') ? uuid.v1() : uuidNew!,
                  title: titleController.text,
                  description: descriptionController.text,
                  category: categoryDropDownValue,
                  Location: locationController.text,
                  dateTime: dateController.text,
                  status: statusDropDownValue,
                  photo: (actionName == 'Save') ? photo ?? ' ' : currentPhoto!,
                );

                try {
                  if (actionName == 'Save') {
                    await context.read<IncidentCubit>().addIncident(incident);
                    Fluttertoast.showToast(
                      msg: "Incident Added Successfully",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                    Navigator.pop(context);
                  } else {
                    await context.read<IncidentCubit>().updateIncident(
                      uuidNew!,
                      incident,
                    );
                    Fluttertoast.showToast(
                      msg: "Incident Updated successfully",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Something went wrong: $e')),
                  );
                }
              }
            },
            child: Text(actionName),
          ),
        ],
      );
    },
  );
}
