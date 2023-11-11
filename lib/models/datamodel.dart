class DataModel {
  String? id;
  String? image;
  String? name;
  String? location;
  double? rating;
  int? distance;
  int? price;
  bool? fav;
  int? reviews;
  DataModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.distance,
      required this.location,
      required this.rating,
      required this.price,
      required this.fav,
      required this.reviews}); //constructor

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'location': location,
        'ratings': rating,
        'distance': distance,
        'price': price,
        'fav': fav,
        'reviews': reviews
      };

  static DataModel fromJson(Map<String, dynamic> json) => DataModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      location: json['location'],
      rating: json['rating'],
      price: json['price'],
      distance: json['distance'],
      fav: json['fav'],
      reviews: json['reviews']);
}
