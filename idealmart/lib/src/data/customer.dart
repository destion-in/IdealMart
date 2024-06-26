class Customer {
  final String email;
  final String password;
  final String name;
  final String pcode;
  final String phone;

  Customer({
    required this.email,
    required this.password,
    required this.name,
    required this.pcode,
    required this.phone,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      email: json['email'],
      password: json['password'],
      name: json['name'],
      pcode: json['pcode'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'pcode': pcode,
      'phone': phone,
    };
  }
}
