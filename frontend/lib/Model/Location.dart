class Location {
  String? cityId;
  String? categoryId;
  String title;
  int visitedTime;
  double longitude;
  double latitude;
  // int createdAt;
  String status;
  bool updatedByUser;
  bool isAutomaticAdded;
  List<dynamic> pictures;
  String userId;
  String id;
  String address;
  String country;
  String district;
  String homeNumber;

  Location({
    required this.cityId,
    required this.categoryId,
    required this.title ,
    required this.visitedTime,
    required this.longitude,
    required this.latitude,
    // required this.createdAt,
    required this.status,
    required this.updatedByUser,
    required this.isAutomaticAdded,
    required this.pictures,
    required this.userId,
    required this.id,
    required this.address,
    required this.country,
    required this.district,
    required this.homeNumber,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      cityId: json['cityId'] ?? "674990d0af248d3b800e31f7",
      categoryId: json['categoryId'] ?? "6749c77473001346446af335",
      title: json['title'],
      visitedTime: json['visitedTime'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      // createdAt: json['createdAt'],
      status: json['status'],
      updatedByUser: json['updatedByUser'],
      isAutomaticAdded: json['isAutomaticAdded'],
      pictures: json['pictures'],
      userId: json['userId'],
      id: json['id'],
      address: json['address'],
      country: json['country'],
      district: json['district'],
      homeNumber: json['homeNumber'],
    );
  }
}


class InfoVisit {
  String address;
  String country;
  String district;
  String homeNumber;
  String commune;
  String province;

  InfoVisit({
    required this.address,
    required this.country,
    required this.district ,
    required this.homeNumber,
    required this.commune,
    required this.province,
  });

  factory InfoVisit.fromJson(Map<String, dynamic> json) {
    return InfoVisit(
      address: json['address'],
      country: json['country'],
      district: json['district'],
      homeNumber: json['homeNumber'],
      commune: json['commune'],
      province: json['province'],

    );
  }
}