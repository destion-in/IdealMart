class Store {
  final int uid;
  final String storeId;
  final String name;
  final String category;
  final String streetNumber;
  final String streetName;
  final String unitNumber;
  final String city;
  final String province;
  final String pcode;
  final String country;
  final String? storeDescription;
  final String email;
  final String phone;

  Store({
    required this.uid,
    required this.storeId,
    required this.name,
    required this.category,
    required this.streetNumber,
    required this.streetName,
    required this.unitNumber,
    required this.city,
    required this.province,
    required this.pcode,
    required this.country,
    this.storeDescription,
    required this.email,
    required this.phone,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      uid: json['uid'],
      storeId: json['storeId'],
      name: json['name'],
      category: json['category'],
      streetNumber: json['streetNumber'],
      streetName: json['streetName'],
      unitNumber: json['unitNumber'],
      city: json['city'],
      province: json['province'],
      pcode: json['pcode'],
      country: json['country'],
      storeDescription: json['storeDescription'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'storeId': storeId,
      'name': name,
      'category': category,
      'streetNumber': streetNumber,
      'streetName': streetName,
      'unitNumber': unitNumber,
      'city': city,
      'province': province,
      'pcode': pcode,
      'country': country,
      'storeDescription': storeDescription,
      'email': email,
      'phone': phone,
    };
  }
}
