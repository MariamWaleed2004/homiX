class PropertyEntity {
  final String id;
  final String title;
  final String category;
  final String location;
  final double price;
  final List<String> image;
  final double? rating;
  final int? totalReviews;
  final String rooms;
  final String bathrooms;
  final String areaSqft;
  final String agentName;
  final String overview;

  PropertyEntity(
      {required this.id,
      required this.title,
      required this.category,
      required this.location,
      required this.price,
      required this.image,
      required this.rooms,
      required this.bathrooms,
      required this.areaSqft,
      required this.agentName,
      required this.overview,
      this.rating,
      this.totalReviews,
      t
      });
}
