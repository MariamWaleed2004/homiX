import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homix/features/favorites/data/datasources/favorites_remote_data_source.dart';
import 'package:homix/features/home/data/models/property_model.dart';

class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource{
  final FirebaseFirestore firebaseFirestore;

  FavoritesRemoteDataSourceImpl({required this.firebaseFirestore});


  @override
  Future<void> toggleFavorites(String userId, String propertyId) async {
    final userRef = firebaseFirestore.collection('favorites').doc(userId);

    await firebaseFirestore.runTransaction((transaction) async {
      final userDoc = await transaction.get(userRef);
      if (!userDoc.exists) {
        transaction.set(userRef, {'favorites': [propertyId]});
      } else {
        final favorites = List<String>.from(userDoc['favorites']);
        if (favorites.contains(propertyId)) {
          favorites.remove(propertyId);
        } else {
          favorites.add(propertyId);
        }
        transaction.update(userRef, {'favorites': favorites});
      }
    });
  }


Future<List<PropertyModel>> getUserFavorites(String userId) async {
  final favDoc = await firebaseFirestore.collection('favorites').doc(userId).get();

  if (!favDoc.exists || favDoc.data() == null) return [];

  final favIds = List<String>.from(favDoc.data()!['favorites'] ?? []);

  if (favIds.isEmpty) return [];

  final querySnapshot = await firebaseFirestore
      .collection('properties')
      .where(FieldPath.documentId, whereIn: favIds)
      .get();

  return querySnapshot.docs
      .map((doc) => PropertyModel.fromMap(doc.data(), doc.id))
      .toList();
}



}


