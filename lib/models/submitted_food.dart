


class SubmittedFood {
  final int id;
  final String image;
  final String name;
  final String cuisine;
  final String rating;

  SubmittedFood({
    required this.id,
    required this.image,
    required this.name,
    required this.cuisine,
    required this.rating,
  });
  SubmittedFood.fromMap(Map<String, dynamic> result)
      : id = result["id"],
        name = result["name"],
        cuisine = result["cuisine"],
        rating = result["rating"],
        image = result["image"];

  Map<String, Object> toMap() {
    return {
      'id': id,
      'name': name,
      'cuisine': cuisine,
      'rating': rating,
      'image':image
    };
  }

}
