import 'package:hive_flutter/hive_flutter.dart';
import 'package:incident_tracker/features/home/data/models/incident_model.dart';

class HiveServices {
  final box = Hive.box('myIncidents');

  Future addIncident(IncidentModel incident) async {
    try {
      await box.put(incident.uuid, incident.toJson());
    } catch (e) {
      throw Future.error(e.toString());
    }
  }

  List<IncidentModel> fetchAllIncidents() {
    try {
      Map<dynamic, dynamic> allItemsMap = box.toMap();
      List<dynamic> allItems = allItemsMap.values.toList();

      if (allItems.isNotEmpty) {
        return allItems.map((json) => IncidentModel.fromJson(json)).toList();
      } else {
        throw Exception(
          'Expected a list of properties but got ${allItems.runtimeType}',
        );
      }
    } catch (e) {
      // Catch other errors
      throw 'No incident yet';
    }
  }

  Future<void> updateIncident(
    String uuid,
    IncidentModel updatedIncident,
  ) async {
    if (box.containsKey(uuid)) {
      await box.put(uuid, updatedIncident.toJson());
    } else {
      print('Incident with UUID $uuid not found');
    }
  }

  Future deleteIncident(String uuid) async {
    if (box.containsKey(uuid)) {
      await box.delete(uuid);
    }
  }
}
