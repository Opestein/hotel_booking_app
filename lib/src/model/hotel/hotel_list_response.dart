class HotelListResponse {
  final SearchParameters? searchParameters;
  final List<Organic>? organic;
  final List<Place>? places;
  final List<PeopleAlsoAsk>? peopleAlsoAsk;
  final List<RelatedSearch>? relatedSearches;
  final int? credits;

  HotelListResponse({
    this.searchParameters,
    this.organic,
    this.places,
    this.peopleAlsoAsk,
    this.relatedSearches,
    this.credits,
  });

  factory HotelListResponse.fromJson(Map<String, dynamic> json) =>
      HotelListResponse(
        searchParameters: json["searchParameters"] == null
            ? null
            : SearchParameters.fromJson(json["searchParameters"]),
        organic: json["organic"] == null
            ? []
            : List<Organic>.from(
                json["organic"]!.map((x) => Organic.fromJson(x))),
        places: json["places"] == null
            ? []
            : List<Place>.from(json["places"]!.map((x) => Place.fromJson(x))),
        peopleAlsoAsk: json["peopleAlsoAsk"] == null
            ? []
            : List<PeopleAlsoAsk>.from(
                json["peopleAlsoAsk"]!.map((x) => PeopleAlsoAsk.fromJson(x))),
        relatedSearches: json["relatedSearches"] == null
            ? []
            : List<RelatedSearch>.from(
                json["relatedSearches"]!.map((x) => RelatedSearch.fromJson(x))),
        credits: json["credits"],
      );

  Map<String, dynamic> toJson() => {
        "searchParameters": searchParameters?.toJson(),
        "organic": organic == null
            ? []
            : List<dynamic>.from(organic!.map((x) => x.toJson())),
        "places": places == null
            ? []
            : List<dynamic>.from(places!.map((x) => x.toJson())),
        "peopleAlsoAsk": peopleAlsoAsk == null
            ? []
            : List<dynamic>.from(peopleAlsoAsk!.map((x) => x.toJson())),
        "relatedSearches": relatedSearches == null
            ? []
            : List<dynamic>.from(relatedSearches!.map((x) => x.toJson())),
        "credits": credits,
      };
}

class Organic {
  final String? title;
  final String? link;
  final String? snippet;
  final int? position;
  final double? rating;
  final int? ratingCount;
  final String? priceRange;
  final String? date;
  final List<Sitelink>? sitelinks;

  Organic({
    this.title,
    this.link,
    this.snippet,
    this.position,
    this.rating,
    this.ratingCount,
    this.priceRange,
    this.date,
    this.sitelinks,
  });

  factory Organic.fromJson(Map<String, dynamic> json) => Organic(
        title: json["title"],
        link: json["link"],
        snippet: json["snippet"],
        position: json["position"],
        rating: json["rating"]?.toDouble(),
        ratingCount: json["ratingCount"],
        priceRange: json["priceRange"],
        date: json["date"],
        sitelinks: json["sitelinks"] == null
            ? []
            : List<Sitelink>.from(
                json["sitelinks"]!.map((x) => Sitelink.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "link": link,
        "snippet": snippet,
        "position": position,
        "rating": rating,
        "ratingCount": ratingCount,
        "priceRange": priceRange,
        "date": date,
        "sitelinks": sitelinks == null
            ? []
            : List<dynamic>.from(sitelinks!.map((x) => x.toJson())),
      };
}

class Sitelink {
  final String? title;
  final String? link;

  Sitelink({
    this.title,
    this.link,
  });

  factory Sitelink.fromJson(Map<String, dynamic> json) => Sitelink(
        title: json["title"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "link": link,
      };
}

class PeopleAlsoAsk {
  final String? question;
  final String? snippet;
  final String? title;
  final String? link;

  PeopleAlsoAsk({
    this.question,
    this.snippet,
    this.title,
    this.link,
  });

  factory PeopleAlsoAsk.fromJson(Map<String, dynamic> json) => PeopleAlsoAsk(
        question: json["question"],
        snippet: json["snippet"],
        title: json["title"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "snippet": snippet,
        "title": title,
        "link": link,
      };
}

class Place {
  final String? title;
  final String? address;
  final double? rating;
  final int? ratingCount;
  final String? cid;

  Place({
    this.title,
    this.address,
    this.rating,
    this.ratingCount,
    this.cid,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        title: json["title"],
        address: json["address"],
        rating: json["rating"]?.toDouble(),
        ratingCount: json["ratingCount"],
        cid: json["cid"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "address": address,
        "rating": rating,
        "ratingCount": ratingCount,
        "cid": cid,
      };
}

class RelatedSearch {
  final String? query;

  RelatedSearch({
    this.query,
  });

  factory RelatedSearch.fromJson(Map<String, dynamic> json) => RelatedSearch(
        query: json["query"],
      );

  Map<String, dynamic> toJson() => {
        "query": query,
      };
}

class SearchParameters {
  final String? q;
  final String? type;
  final String? engine;

  SearchParameters({
    this.q,
    this.type,
    this.engine,
  });

  factory SearchParameters.fromJson(Map<String, dynamic> json) =>
      SearchParameters(
        q: json["q"],
        type: json["type"],
        engine: json["engine"],
      );

  Map<String, dynamic> toJson() => {
        "q": q,
        "type": type,
        "engine": engine,
      };
}
