import 'package:incident_tracker/features/home/data/models/incident_model.dart';

abstract class IncidentRepo {
  Future addIncident(IncidentModel incident);
  fetchAllIncidents();
  Future updateIncident(String uuid, IncidentModel updatedIncident);
  Future deleteIncident(String uuid);
}
