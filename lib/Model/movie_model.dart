class Movie {
  final String title;
  final String description;
  final String image;
  final bool shouldShowDescription;

  Movie({
    required this.title,
    required this.description,
    required this.image,
    required this.shouldShowDescription,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    // Convert the value to a bool if it's an int or other type
    dynamic shouldShowDesc = json['shouldShowDescription'];
    bool shouldShowDescription =
        shouldShowDesc is bool ? shouldShowDesc : shouldShowDesc == 1;

    return Movie(
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      image: json['image'] ?? "",
      shouldShowDescription: shouldShowDescription,
    );
  }
}
