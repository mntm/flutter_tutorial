part of 'user.dart';

class UserCompany {
  final String name;
  final String catchPhrase;
  final String bs;

  UserCompany({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  UserCompany.fromJson(dynamic src)
      : bs = src["bs"],
        catchPhrase = src["catchPhrase"],
        name = src["name"];
}
