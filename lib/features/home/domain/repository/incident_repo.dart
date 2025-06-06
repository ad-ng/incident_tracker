import 'package:incident_tracker/features/home/data/models/incident_model.dart';

abstract class IncidentRepo {
  Future addIncident(IncidentModel incident);
  List<IncidentModel> fetchAllIncidents();
  Future updateIncident(int id, IncidentModel updatedIncident);
  Future deleteIncident(int id);
}
