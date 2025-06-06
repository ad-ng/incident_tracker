import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incident_tracker/features/home/presentation/bloc/incidents_cubit.dart';
import 'package:incident_tracker/features/home/presentation/widgets/incidentCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<IncidentCubit>(context).fetchAllIncidents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<IncidentCubit, IncidentState>(
            builder: (context, state) {
              if (state is IncidentAllSuccess) {
                return ListView.builder(
                  itemCount: state.response.length,
                  itemBuilder:
                      (context, index) =>
                          IncidentCard(incidentModel: state.response[index]),
                );
              }
              if (state is IncidentError) {
                return Center(
                  child: Text(
                    state.error,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue,
                    ),
                  ),
                );
              }
              if (state is IncidentLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
