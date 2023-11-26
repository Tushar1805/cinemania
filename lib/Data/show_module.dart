import 'externals_module.dart';
import 'image_module.dart';
import 'links_module.dart';
import 'network_module.dart';
import 'rating_module.dart';
import 'schedule_module.dart';

class Show {
  int id;
  String url;
  String name;
  String type;
  String language;
  List<String> genres;
  String status;
  int runtime;
  int averageRuntime;
  String premiered;
  String ended;
  String officialSite;
  Schedule schedule;
  Rating rating;
  int weight;
  Network network;
  dynamic webChannel;
  dynamic dvdCountry;
  Externals externals;
  Image image;
  String summary;
  int updated;
  Links links;

  Show({
    this.id,
    this.url,
    this.name,
    this.type,
    this.language,
    this.genres,
    this.status,
    this.runtime,
    this.averageRuntime,
    this.premiered,
    this.ended,
    this.officialSite,
    this.schedule,
    this.rating,
    this.weight,
    this.network,
    this.webChannel,
    this.dvdCountry,
    this.externals,
    this.image,
    this.summary,
    this.updated,
    this.links,
  });

  factory Show.fromJson(Map<String, dynamic> json) => Show(
        id: json["id"],
        url: json["url"],
        name: json["name"],
        type: json["type"],
        language: json["language"],
        genres: List<String>.from(json["genres"].map((x) => x)),
        status: json["status"],
        runtime: json["runtime"],
        averageRuntime: json["averageRuntime"],
        premiered: json["premiered"],
        ended: json["ended"],
        officialSite: json["officialSite"],
        schedule: Schedule.fromJson(json["schedule"]),
        rating: Rating.fromJson(json["rating"]),
        weight: json["weight"],
        network:
            json["network"] != null ? Network.fromJson(json["network"]) : null,
        webChannel: json["webChannel"],
        dvdCountry: json["dvdCountry"],
        externals: Externals.fromJson(json["externals"]),
        image: json["image"] != null ? Image.fromJson(json["image"]) : null,
        summary: json["summary"],
        updated: json["updated"],
        links: json["_links"] != null ? Links.fromJson(json["_links"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "name": name,
        "type": type,
        "language": language,
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "status": status,
        "runtime": runtime,
        "averageRuntime": averageRuntime,
        "premiered": premiered,
        "ended": ended,
        // "premiered":
        //     "${premiered.year.toString().padLeft(4, '0')}-${premiered.month.toString().padLeft(2, '0')}-${premiered.day.toString().padLeft(2, '0')}",
        // "ended":
        //     "${ended.year.toString().padLeft(4, '0')}-${ended.month.toString().padLeft(2, '0')}-${ended.day.toString().padLeft(2, '0')}",
        "officialSite": officialSite,
        "schedule": schedule.toJson(),
        "rating": rating.toJson(),
        "weight": weight,
        "network": network.toJson(),
        "webChannel": webChannel,
        "dvdCountry": dvdCountry,
        "externals": externals.toJson(),
        "image": image.toJson(),
        "summary": summary,
        "updated": updated,
        "_links": links.toJson(),
      };
}
