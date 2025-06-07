import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:incident_tracker/features/home/data/models/incident_model.dart';
import 'package:incident_tracker/features/home/domain/usercases/add_incident_dialog.dart';
import 'package:incident_tracker/features/home/presentation/bloc/incidents_cubit.dart';
import 'package:intl/intl.dart';
import 'package:popover/popover.dart';

class IncidentCard extends StatefulWidget {
  final IncidentModel incidentModel;
  const IncidentCard({super.key, required this.incidentModel});

  @override
  State<IncidentCard> createState() => _IncidentCardState();
}

class _IncidentCardState extends State<IncidentCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        color: Colors.blue[300],
        child: ListTile(
          title: Text(
            widget.incidentModel.title,
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    widget.incidentModel.category,
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(width: 10),
                  Text(
                    widget.incidentModel.status,
                    style: TextStyle(color: Colors.yellowAccent[100]),
                  ),
                ],
              ),
              Text(
                DateFormat(
                  'yyyy-MM-dd HH:mm',
                ).format(DateTime.parse(widget.incidentModel.dateTime)),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          leading:
              (widget.incidentModel.photo != ' ')
                  ? Image.memory(
                    base64Decode(widget.incidentModel.photo),
                    height: 40,
                    width: 40,
                  )
                  : SizedBox.shrink(),
          trailing: Builder(
            builder: (context) {
              return GestureDetector(
                onTap:
                    () => showPopover(
                      context: context,
                      bodyBuilder:
                          (context) => Container(
                            height: 80,
                            width: 120,
                            child: Column(
                              children: [
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      TextEditingController titleController =
                                          TextEditingController(
                                            text: widget.incidentModel.title,
                                          );
                                      TextEditingController
                                      descriptionController =
                                          TextEditingController(
                                            text:
                                                widget
                                                    .incidentModel
                                                    .description,
                                          );
                                      TextEditingController locationController =
                                          TextEditingController(
                                            text: widget.incidentModel.Location,
                                          );
                                      TextEditingController dateController =
                                          TextEditingController(
                                            text: widget.incidentModel.dateTime,
                                          );

                                      openModel(
                                        context,
                                        titleController,
                                        descriptionController,
                                        locationController,
                                        dateController,
                                        'Update the incident',
                                        'Update',
                                        widget.incidentModel.category,
                                        widget.incidentModel.status,
                                        widget.incidentModel.uuid,
                                        widget.incidentModel.photo,
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Edit',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        SizedBox(width: 5),
                                        Icon(Icons.edit),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('confirmation dialog'),
                                            content: Text(
                                              'Are you sure you want to delete this incident ?',
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
                                                  BlocProvider.of<
                                                    IncidentCubit
                                                  >(context).deleteIncident(
                                                    widget.incidentModel.uuid,
                                                  );
                                                  Fluttertoast.showToast(
                                                    msg:
                                                        "Incident deleted successfully",
                                                    toastLength:
                                                        Toast.LENGTH_LONG,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    backgroundColor:
                                                        Colors.blue,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0,
                                                  );
                                                },
                                                child: Text('Delete'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Delete',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Icon(Icons.delete, color: Colors.white),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      direction: PopoverDirection.right,
                    ),
                child: Icon(Icons.more_vert_outlined, color: Colors.white),
              );
            },
          ),
        ),
      ),
    );
  }
}
