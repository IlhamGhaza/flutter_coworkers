class WorkerModel {
  String image;
  String name;
  String location;
  int experience;
  double hourRate;
  double rating;
  double ratingCount;
  String status;
  String about;
  List<String> strengths;
  String category;
  String $id;
  String $createdAt;
  String $updatedAt;

  WorkerModel({
    required this.image,
    required this.name,
    required this.location,
    required this.experience,
    required this.hourRate,
    required this.rating,
    required this.ratingCount,
    required this.status,
    required this.about,
    required this.strengths,
    required this.category,
    required this.$id,
    required this.$createdAt,
    required this.$updatedAt,
  });

  factory WorkerModel.fromJson(Map<String, dynamic> json) => WorkerModel(
        image: json["image"],
        name: json["name"],
        location: json["location"],
        experience: json["experience"],
        hourRate: json["hour_rate"]?.toDouble(),
        rating: json["rating"]?.toDouble(),
        ratingCount: json["rating_count"]?.toDouble(),
        status: json["status"],
        about: json["about"],
        strengths: List<String>.from(json["strengths"].map((x) => x)),
        category: json["category"],
        $id: json["\$id"],
        $createdAt: json["\$createdAt"],
        $updatedAt: json["\$updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "location": location,
        "experience": experience,
        "hour_rate": hourRate,
        "rating": rating,
        "rating_count": ratingCount,
        "status": status,
        "about": about,
        "strengths": List<dynamic>.from(strengths.map((x) => x)),
        "category": category,
        "\$id": $id,
        "\$createdAt": $createdAt,
        "\$updatedAt": $updatedAt,
      };
}
