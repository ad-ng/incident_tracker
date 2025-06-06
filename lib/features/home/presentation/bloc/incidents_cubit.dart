import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incident_tracker/features/home/data/models/incident_model.dart';
import 'package:incident_tracker/features/home/domain/repository/incident_repo.dart';

class IncidentCubit extends Cubit<IncidentState> {
  final IncidentRepo incidentRepo;
  IncidentCubit(this.incidentRepo) : super(IncidentInitial());

  Future addIncident(IncidentModel incident) async {
    emit(IncidentLoading());
    try {
      final response = await incidentRepo.addIncident(incident);
      emit(IncidentSuccess(response));
    } catch (e) {
      emit(IncidentError(e.toString()));
    }
  }

  fetchAllIncidents() {
    emit(IncidentLoading());
    try {
      final response = incidentRepo.fetchAllIncidents();
      return emit(IncidentSuccess(response));
    } catch (e) {
      emit(IncidentError(e.toString()));
    }
  }

  Future updateIncident(int id, IncidentModel updatedIncident) async {
    emit(IncidentLoading());
    try {
      final response = incidentRepo.updateIncident(id, updatedIncident);
      return emit(IncidentSuccess(response));
    } catch (e) {
      emit(IncidentError(e.toString()));
    }
  }

  Future deleteIncident(int id) async {
    emit(IncidentLoading());
    try {
      final response = incidentRepo.deleteIncident(id);
      return emit(IncidentSuccess(response));
    } catch (e) {
      emit(IncidentError(e.toString()));
    }
  }
}

abstract class IncidentState {}

class IncidentInitial extends IncidentState {}

class IncidentLoading extends IncidentState {}

class IncidentSuccess extends IncidentState {
  final response;
  IncidentSuccess(this.response);
}

class IncidentError extends IncidentState {
  final String error;
  IncidentError(this.error);
}
