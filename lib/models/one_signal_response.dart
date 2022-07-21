class OneSignalResponse {
  final String? id;
  final int? recipients;
  final String? externalId;
  final dynamic errors;

  OneSignalResponse({
    this.id,
    this.recipients,
    this.externalId,
    this.errors,
  });

  OneSignalResponse.fromJson(Map<String, dynamic> json):
    id = json['id'],
    recipients = json['recipients'],
    externalId = json['external_id'],
    errors = json['errors'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'recipients': recipients,
    'external_id': externalId,
    'errors': errors,
  };
}