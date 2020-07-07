import 'package:json_annotation/json_annotation.dart';

part 'user_details.g.dart';

@JsonSerializable(nullable: true)
class UserDetails {
  String email;
  String firstName;
  String lastName;
  String address;
  String phone;
  String image;
  bool admin;

  UserDetails(
      {this.email,
      this.firstName,
      this.lastName,
      this.address,
      this.phone,
      this.image,
      this.admin});

  factory UserDetails.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);

  @override
  String toString() {
    return '''UserDetails {
      email: $email,
      firstName: $firstName,
      lastName: $lastName,
      address: $address,
      phone: $phone,
      image: $image,
      admin: $admin,
    }''';
  }
}
