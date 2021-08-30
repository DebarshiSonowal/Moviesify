

import 'dart:convert';

class media_provider{

  int id;
  String name,image;

  media_provider({this.id, this.name, this.image});


  String get fullImageUrl => 'https://image.tmdb.org/t/p/w200$image';

  Map<String, dynamic> toMap() {
    return {
      'provider_name': name,
      'logo_path': image,
      'provider_id': id
    };
  }

  factory media_provider.fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return media_provider(
          id: 1,
        image: '',
        name: '',
      );
    }
    return media_provider(
        name: map['provider_name'],
       image:map['logo_path'],
        id: map['provider_id']);
  }

  String toJson() => json.encode(toMap);

  factory media_provider.fromJson(String source) => media_provider.fromMap(json.decode(source));

}