class OneSignalPush {
  String? appId;
  List<String>? playerIds;
  String? name;
  String? headings;
  String? contents;
  List<String>? includeExternalUserId;

  OneSignalPush({
    this.appId,
    this.playerIds,
    this.name,
    this.headings,
    this.contents,
    this.includeExternalUserId,
  });

  OneSignalPush.fromJson(Map<String, dynamic> json):
    appId = json['app_id'],
    playerIds = json['playerIds'],
    name = json['name'],
    headings = json['headings'],
    contents = json['contents'],
    includeExternalUserId = json['include_external_user_ids'];

  Map<String, dynamic> toJson() => {
    'app_id': appId,
    'playerIds': playerIds,
    'name': name,
    'headings': {'en': headings},
    'contents': {'en': contents},
    'include_external_user_ids': includeExternalUserId,
  };
}
