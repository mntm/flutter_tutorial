part 'user_company.dart';
part 'user_location.dart';

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final UserLocation address;
  final String phone;
  final Uri website;
  final UserCompany company;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  User.fromJson(dynamic src)
      : address = UserLocation.fromJson(src["address"]),
        company = UserCompany.fromJson(src["company"]),
        email = src["email"],
        id = src["id"],
        name = src["name"],
        phone = src["phone"],
        username = src["username"],
        website = Uri.parse(src["website"]);
}
