import 'package:quadb_tech/Data/previousEpisode_module.dart';

class Links {
  Previousepisode self;
  Previousepisode previousepisode;

  Links({
    this.self,
    this.previousepisode,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: Previousepisode.fromJson(json["self"]),
        previousepisode: json["previousepisode"] != null
            ? Previousepisode.fromJson(json["previousepisode"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "self": self.toJson(),
        "previousepisode": previousepisode.toJson(),
      };
}
