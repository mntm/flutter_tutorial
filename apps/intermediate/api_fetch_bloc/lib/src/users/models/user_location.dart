part of 'user.dart';

class UserLocation {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final GeoLocation geo;

  UserLocation({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  UserLocation.fromJson(dynamic src)
      : city = src["city"],
        street = src["street"],
        suite = src["suite"],
        zipcode = src["zipcode"],
        geo = GeoLocation.fromJson(src["geo"]);
}

class GeoLocation {
  final double lat;
  final double lng;

  GeoLocation({
    required this.lat,
    required this.lng,
  });

  GeoLocation.fromJson(dynamic src)
      : lat = double.parse(src["lat"]),
        lng = double.parse(src["lng"]);
}
