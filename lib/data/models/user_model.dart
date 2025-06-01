class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String image;
  final String phone;
  final String gender;
  final String birthDate;
  final Address address;
  final Company company;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
    required this.phone,
    required this.gender,
    required this.birthDate,
    required this.address,
    required this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    email: json['email'],
    image: json['image'],
    phone: json['phone'],
    gender: json['gender'],
    birthDate: json['birthDate'],
    address: Address.fromJson(json['address']),
    company: Company.fromJson(json['company']),
  );
}

class Address {
  final String address;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  Address({
    required this.address,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    address: json['address'],
    city: json['city'],
    state: json['state'],
    postalCode: json['postalCode'],
    country: json['country'],
  );
}

class Company {
  final String name;
  final String title;
  final String department;

  Company({
    required this.name,
    required this.title,
    required this.department,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    name: json['name'],
    title: json['title'],
    department: json['department'],
  );
}