import 'package:incident_tracker/features/home/data/datasources/local/hiveServices.dart';
import 'package:incident_tracker/features/home/data/models/incident_model.dart';
import 'package:incident_tracker/features/home/domain/repository/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  @override
  Future addIncident(IncidentModel incident) async {
    return await HiveServices().addIncident(incident);
  }

  @override
  Future deleteIncident(int id) async {
    return await HiveServices().deleteIncident(id);
  }

  @override
  List<IncidentModel> fetchAllIncidents() {
    return HiveServices().fetchAllIncidents();
  }

  @override
  Future updateIncident(int id, IncidentModel updatedIncident) async {
    return HiveServices().updateIncident(id, updatedIncident);
  }
}
