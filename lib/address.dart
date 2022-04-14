class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo geo;

  Address({required this.street, required this.suite, required this.city, required this.zipcode, required this.geo});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      suite: json['suite'],
      city: json['city'],
      zipcode: json['zipcode'],
      geo: json['geo'] = Geo.fromJson(json['geo']),
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['suite'] = this.suite;
    data['city'] = this.city;
    data['zipcode'] = this.zipcode;
    data['geo'] = this.geo.toJson();
    return data;
  }
}
class Geo {
  final String lat;
  final String lng;

  Geo({required this.lat, required this.lng});
  factory Geo.fromJson(Map<String,dynamic> json) {
    return Geo(
      lat: json['lat'],
      lng: json['lng'],);
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
