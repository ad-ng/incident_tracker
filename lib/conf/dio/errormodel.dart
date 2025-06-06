class ErrorModel {
  final List<String> message;
  final bool error;

  ErrorModel({required this.message, required this.error});

  // Modify fromJson to properly handle the data.
  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      message: List<String>.from(json['message'] ?? []),
      error: json['error'] ?? 'false',
    );
  }
}
