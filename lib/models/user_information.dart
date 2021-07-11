import 'package:hive/hive.dart';

part 'user_information.g.dart';

@HiveType(typeId: 2)
class UserInformation extends HiveObject {
  @HiveField(0)
  String email;
  @HiveField(1)
  String first_name;
  @HiveField(2)
  String last_name;
  @HiveField(3)
  String address;
  @HiveField(4)
  String city;
  @HiveField(5)
  String country;
  @HiveField(6)
  int postal_code;
  @HiveField(7)
  int phone;
  @HiveField(8)
  int id;

  UserInformation({
    this.email,
    this.first_name,
    this.last_name,
    this.address,
    this.city,
    this.country,
    this.postal_code,
    this.phone,
    this.id,
  });

  factory UserInformation.fromJson(Map<String, dynamic> json) {
    return UserInformation(
      id: json['id'],
      email: json['email'],
      first_name: json['name'],
    );
  }
}
