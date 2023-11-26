class Rating {
  double average;

  Rating({
    this.average,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        average: (json["average"] != null) ? json["average"].toDouble() : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "average": average,
      };
}
