import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class IncidentModel {
  int id;
  String title;
  String description;
  String category;
  String Location;
  String dateTime;
  String status;
  String photo;
  IncidentModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.Location,
    required this.dateTime,
    required this.status,
    required this.photo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'Location': Location,
      'dateTime': dateTime,
      'status': status,
      'photo': photo,
    };
  }

  factory IncidentModel.fromMap(Map<String, dynamic> map) {
    return IncidentModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      Location: map['Location'] as String,
      dateTime: map['dateTime'] as String,
      status: map['status'] as String,
      photo: map['photo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory IncidentModel.fromJson(String source) =>
      IncidentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
