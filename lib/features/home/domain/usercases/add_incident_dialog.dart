import 'package:flutter/material.dart';

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
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(actionName),
          ),
        ],
      );
    },
  );
}
