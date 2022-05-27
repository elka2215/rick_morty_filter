class NetworkResponse {
  NetworkResponse({
    required this.info,
    required this.results,
  });

  final InfoCharacter info;
  final List<Character> results;

  factory NetworkResponse.fromJson(Map<String, dynamic> json) =>
      NetworkResponse(
        info: InfoCharacter.fromJson(json["info"]),
        results:
            List<Character>.from(json["results"].map((x) => Character.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class InfoCharacter {
  InfoCharacter({
    this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  final int? count;
  final int pages;
  final String? next;
  final dynamic prev;

  factory InfoCharacter.fromJson(Map<String, dynamic> json) => InfoCharacter(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
      };
}

class Character {
  Character({
     this.id,
     this.name,
     this.status,
     this.species,
     this.type,
     this.gender,
     this.origin,
     this.location,
     this.image,
     this.episode,
     this.url,
     this.created,
  });

  final int? id;
  final String? name;
  final String? status;
  final String? species;
  final String? type;
  final String? gender;
  final Location? origin;
  final Location? location;
  final String? image;
  final List<String>? episode;
  final String? url;
  final String? created;

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        species: json["species"],
        type: json["type"],
        gender: json["gender"] == null ? null : json["gender"],
        origin: json["origin"] == null ? null : Location.fromJson(json["origin"]),
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        image: json["image"],
        episode: json["episode"] != null ? List<String>.from(json["episode"].map((x) => x.toString().replaceAll('https://rickandmortyapi.com/api/', ''))) : null,
        url: json["url"],
        created: json["created"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "species": species,
        "type": type,
        "gender": gender,
        "origin": origin == null ? origin : origin?.toJson(),
        "location": location == null ? null : location?.toJson(),
        "image": image,
        "episode": episode == null ? null : List<dynamic>.from(episode!.map((x) => x)),
        "url": url,
        "created": created,
      };
}


class Location {
  Location({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}



