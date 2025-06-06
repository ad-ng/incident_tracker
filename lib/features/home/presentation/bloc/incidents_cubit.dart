import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incident_tracker/features/home/data/models/incident_model.dart';
import 'package:incident_tracker/features/home/domain/repository/incident_repo.dart';

class IncidentCubit extends Cubit<IncidentState> {
  final IncidentRepo incidentRepo;
  IncidentCubit(this.incidentRepo) : super(IncidentInitial());

  Future addIncident(IncidentModel incident) async {
    try {
      await incidentRepo.addIncident(incident);
      await fetchAllIncidents();
    } catch (e) {
      emit(IncidentError(e.toString()));
    }
  }

  Future fetchAllIncidents() async {
    emit(IncidentLoading());
    try {
      final response = await incidentRepo.fetchAllIncidents();
      return emit(IncidentAllSuccess(response));
    } catch (e) {
      emit(IncidentError(e.toString()));
    }
  }

  Future updateIncident(String uuid, IncidentModel updatedIncident) async {
    try {
      incidentRepo.updateIncident(uuid, updatedIncident);
      await fetchAllIncidents();
    } catch (e) {
      emit(IncidentError(e.toString()));
    }
  }

  Future deleteIncident(String uuid) async {
    try {
      incidentRepo.deleteIncident(uuid);
      await fetchAllIncidents();
    } catch (e) {
      emit(IncidentError(e.toString()));
    }
  }
}

abstract class IncidentState {}

class IncidentInitial extends IncidentState {}

class IncidentLoading extends IncidentState {}

class IncidentAllSuccess extends IncidentState {
  final List<IncidentModel> response;
  IncidentAllSuccess(this.response);
}

class IncidentError extends IncidentState {
  final String error;
  IncidentError(this.error);
}
