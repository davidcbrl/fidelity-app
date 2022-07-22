class EnterpriseDashboard {
  int? totalClients;
  int? totalLoyaltAchieved;
  List<dynamic>? mostUsedLoyalts;
  Map<String, double>? convertedList = Map<String, double>();
  Map<String, double>? convertedListTwo = Map<String, double>();
  EnterpriseDashboard({
    this.totalClients,
    this.totalLoyaltAchieved,
    this.mostUsedLoyalts,
  });

  EnterpriseDashboard.fromJson(Map<String, dynamic> json)
      : totalClients = json['TotalClients'],
        totalLoyaltAchieved = json['TotalLoyaltAchieved'],
        mostUsedLoyalts = json['MostUsedLoyalts'];

  Map<String, dynamic> toJson() => {
        'TotalClients': totalClients,
        'TotalLoyaltAchieved': totalLoyaltAchieved,
        'MostUsedLoyalts': mostUsedLoyalts,
      };
}

class MostUsedLoyaltsItem {
  String? name;
  int? number;

  MostUsedLoyaltsItem.fromJson(Map<String, dynamic> json)
      : name = json['Name'],
        number = json['Number'];

  Map<String, dynamic> toJson() => {
        'Name': name,
        'Number': number,
      };
}
