class ApiResponse {
  final bool success;
  final String message;
  final int count;
  final dynamic result;

  ApiResponse(
    this.success,
    this.message,
    this.count,
    this.result,
  );

  ApiResponse.fromJson(Map<String, dynamic> json):
    success = json['Success'],
    message = json['Message'],
    count = json['Count'],
    result = json['Result'];

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'count': count,
    'result': result,
  };
}