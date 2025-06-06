import 'package:flutter/material.dart';
import 'package:incident_tracker/features/home/data/models/incident_model.dart';
import 'package:incident_tracker/features/home/presentation/widgets/incidentCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

IncidentModel incidentModel = IncidentModel(
  id: 2,
  title: 'incident title',
  description: 'best incident ever',
  category: 'Low Priority',
  Location: 'Kigali',
  dateTime: '1987-11-05T16:59:58.120Z',
  status: 'Open',
  photo: 'image',
);

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 3,
            itemBuilder:
                (context, index) => IncidentCard(incidentModel: incidentModel),
          ),
        ),
      ],
    );
  }
}
