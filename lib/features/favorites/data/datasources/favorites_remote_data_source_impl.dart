import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homix/features/favorites/data/datasources/favorites_remote_data_source.dart';
import 'package:homix/features/home/data/models/property_model.dart';

class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  FavoritesRemoteDataSourceImpl({required this.firebaseFirestore});

  @override
  Future<void> toggleFavorites(String userId, String propertyId) async {
    //print("2222222222222222222222");
    final favRef = firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(propertyId);

    final doc = await favRef.get();

    if (doc.exists) {
      await favRef.delete();
    } else {
      await favRef.set({'favorited': true});
    }
  }

  // @override
  // Future<void> toggleFavorites(String userId, String propertyId) async {
  //   final userRef = firebaseFirestore.collection('users').doc(userId);
  //   final favoritesRef = userRef.collection('favorites').doc(propertyId);

  //   await firebaseFirestore.runTransaction((transaction) async {
  //     final userDoc = await transaction.get(userRef);
  //     if (!userDoc.exists) {

  //       transaction.set(userRef, {});
  //     }

  //     final favoriteDoc = await transaction.get(favoritesRef);

  //     if (!favoriteDoc.exists) {

  //       transaction.set(favoritesRef, {'favorited': true});
  //     } else {

  //       transaction.delete(favoritesRef);
  //     }
  //   });
  // }

  @override
  Future<List<PropertyModel>> getUserFavorites(String userId) async {
    final favCollection = await firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .get();

    if (favCollection.docs.isEmpty) return [];

    final favIds = favCollection.docs.map((doc) => doc.id).toList();

    final querySnapshot = await firebaseFirestore
        .collection('Apartments')
        .where(FieldPath.documentId, whereIn: favIds)
        .get();

   
    return querySnapshot.docs
        .map((doc) => PropertyModel.fromMap(doc.data(), doc.id))
        .toList();
  }
}
