import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homix/features/home/domain/entities/property_entity.dart';

class PropertyModel extends PropertyEntity {
  PropertyModel({
    required super.id,
    required super.title,
    required super.category,
    required super.location,
    required super.price,
    required super.image,
    required super.rooms,
    required super.bathrooms,
    required super.areaSqft,
    required super.agentName,
    required super.overview,
    super.rating,
    super.totalReviews,
  });

  factory PropertyModel.fromMap(Map<String, dynamic> map, String docId) {
    // print(
    //     "DEBUG: map['image'] = ${map['image']} (${map['image'].runtimeType})");
    return PropertyModel(
      id: docId,
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      location: map['location'] ?? '',
      rooms: map['rooms'] ?? '',
      bathrooms: map['bathrooms'] ?? '',
      areaSqft: map['areaSqft'] ?? '',
      agentName: map['agentName'] ?? '',
      overview: map['overview'] ?? '',
      price: double.tryParse(map['price'].toString()) ?? 0.0,
      image: (map['image'] is List)
          ? List<String>.from(map['image'])
          : [map['image'] ?? ''],
      rating: double.tryParse(map['rating'].toString()) ?? 0.0,
      totalReviews: int.tryParse(map['totalReviews'].toString()) ?? 0,
    );
  }

  factory PropertyModel.fromFirestore(DocumentSnapshot doc) {
  final data = doc.data() as Map<String, dynamic>;
  return PropertyModel.fromMap(data, doc.id);
}



}
