import 'package:hive_flutter/hive_flutter.dart';
import 'package:incident_tracker/features/home/data/models/incident_model.dart';

class HiveServices {
  final box = Hive.box('myIncidents');

  Future addIncident(IncidentModel incident) async {
    try {
      final newIncident = await box.put(incident.id, incident.toJson());
      return newIncident;
    } catch (e) {
      throw Future.error(e.toString());
    }
  }

  List<IncidentModel> fetchAllIncidents() {
    return box.keys.map((key) {
      final json = box.get(key);
      final incident = IncidentModel.fromJson(json);
      return incident;
    }).toList();
  }

  Future updateIncident(int id, IncidentModel updatedIncident) async {
    if (box.containsKey(id)) {
      await box.put(id, updatedIncident.toJson());
    }
  }

  Future deleteIncident(int id) async {
    if (box.containsKey(id)) {
      await box.delete(id);
    }
  }
}
