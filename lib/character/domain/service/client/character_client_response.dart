import 'dart:convert';

import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/application/domain/entity/nationality.dart';

CharacterClientResponse characterClientResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return CharacterClientResponse.fromJson(jsonData);
}

String characterClientResponseToJson(CharacterClientResponse data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class CharacterClientResponse {
  List<CharacterClientModel> results;

  CharacterClientResponse({
    this.results,
  });

  factory CharacterClientResponse.fromJson(Map<String, dynamic> json) =>
      new CharacterClientResponse(
        results: new List<CharacterClientModel>.from(
            json['results'].map((x) => CharacterClientModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'results': new List<dynamic>.from(results.map((x) => x.toJson())),
      };

  List<Character> toCharacterList() {
    return results
        .map((CharacterClientModel characterClientModel) =>
            characterClientModel.toCharacter())
        .toList();
  }
}

class CharacterClientModel {
  final _mapOriginResponseToDomain = {
    'AU': Nationality.australia,
    'BR': Nationality.brazil,
    'CA': Nationality.canada,
    'CH': Nationality.switzerland,
    'DE': Nationality.germany,
    'DK': Nationality.denmark,
    'ES': Nationality.spain,
    'FI': Nationality.finland,
    'FR': Nationality.france,
    'GB': Nationality.unitedKingdom,
    'IE': Nationality.ireland,
    'IR': Nationality.iran,
    'NO': Nationality.norway,
    'NL': Nationality.netherlands,
    'NZ': Nationality.newZealand,
    'TR': Nationality.turkey,
    'US': Nationality.unitedStates,
  };

  String gender;
  Name name;
  String email;
  Picture picture;
  String nat;

  CharacterClientModel({
    this.gender,
    this.name,
    this.email,
    this.picture,
    this.nat,
  });

  factory CharacterClientModel.fromJson(Map<String, dynamic> json) =>
      new CharacterClientModel(
        gender: json['gender'],
        name: Name.fromJson(json['name']),
        email: json['email'],
        picture: Picture.fromJson(json['picture']),
        nat: json['nat'],
      );

  Map<String, dynamic> toJson() => {
        'gender': gender,
        'name': name.toJson(),
        'email': email,
        'picture': picture.toJson(),
        'nat': nat,
      };

  Character toCharacter() {
    return Character(
      firstName: name.first,
      lastName: name.last,
      gender: gender,
      origin: _mapOriginResponseToDomain[nat],
      graduates: [],
      currentJob: null,
      jobHistory: [],
      age: 0,
      school: School.None,
    );
  }
}

class Name {
  String title;
  String first;
  String last;

  Name({
    this.title,
    this.first,
    this.last,
  });

  factory Name.fromJson(Map<String, dynamic> json) => new Name(
        title: json['title'],
        first: json['first'],
        last: json['last'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'first': first,
        'last': last,
      };
}

class Picture {
  String large;
  String medium;
  String thumbnail;

  Picture({
    this.large,
    this.medium,
    this.thumbnail,
  });

  factory Picture.fromJson(Map<String, dynamic> json) => new Picture(
        large: json['large'],
        medium: json['medium'],
        thumbnail: json['thumbnail'],
      );

  Map<String, dynamic> toJson() => {
        'large': large,
        'medium': medium,
        'thumbnail': thumbnail,
      };
}
