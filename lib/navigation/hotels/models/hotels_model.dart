class Hotels {
  final String name;
  final String city;
  final String bookingUrl;
  final String imageUrl;
  final double rating;
  final String description;
  final int reviewsCount;
  final int stars;
  final String lastUpdated;
  final int pricePerNight;

  Hotels({
    required this.name,
    required this.city,
    required this.bookingUrl,
    required this.imageUrl,
    required this.rating,
    required this.description,
    required this.reviewsCount,
    required this.stars,
    required this.lastUpdated,
    required this.pricePerNight,
  });

  factory Hotels.fromJson(Map<String, dynamic> json) {
    final List<dynamic> rooms = json['rooms'] ?? [];
    int extractedPrice = 0;

    if (rooms.isNotEmpty) {
      final firstRoom = rooms.first;
      extractedPrice = (firstRoom['price_egp_per_night'] ?? 0);
    }

    return Hotels(
      name: json['name'] ?? '',
      city: json['city'] ?? '',
      bookingUrl: json['booking_url'] ?? '',
      imageUrl: json['image_url'] ?? '',
      rating: (json['rating'] is int)
          ? (json['rating'] as int).toDouble()
          : (json['rating'] ?? 0.0).toDouble(),
      description: json['description'] ?? '',
      reviewsCount: json['reviews_count'] ?? 0,
      stars: json['stars'] ?? 0,
      lastUpdated: json['last_updated'] ?? '',
      pricePerNight: extractedPrice,
    );
  }
}
