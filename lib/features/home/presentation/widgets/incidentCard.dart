import 'package:flutter/material.dart';
import 'package:incident_tracker/features/home/data/models/incident_model.dart';
import 'package:incident_tracker/features/home/presentation/pages/home_page.dart';
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
        child: ListTile(
          title: Text(incidentModel.title),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(incidentModel.category),
                  SizedBox(width: 10),
                  Text(incidentModel.status),
                ],
              ),
              Text(incidentModel.dateTime.substring(0, 10)),
            ],
          ),
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(color: Colors.blue),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                              ],
                            ),
                          ),
                      direction: PopoverDirection.right,
                    ),
                child: Icon(Icons.more_vert_outlined),
              );
            },
          ),
        ),
      ),
    );
  }
}
