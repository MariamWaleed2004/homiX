import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:homix/features/home/domain/entities/property_entity.dart';
import 'package:homix/features/home/domain/usecases/get_property_usecase.dart';

part 'property_state.dart';

class PropertyCubit extends Cubit<PropertyState> {
  final GetPropertyUsecase getPropertyUsecase;

  PropertyCubit({required this.getPropertyUsecase}) : super(PropertyInitial());

  Future<void> getProperties() async {
    try {
      emit(PropertyLoading());
      final properties = await getPropertyUsecase();

      final propertiesWithRating = await Future.wait(
        properties.map((property) async {
          final data = await getAverageRatingAndCount(property.id);
          return PropertyEntity(
            id: property.id,
            homeDisplay: property.homeDisplay,
            title: property.title,
            category: property.category,
            location: property.location,
            rooms: property.rooms,
            bathrooms: property.bathrooms,
            areaSqft: property.areaSqft,
            agentName: property.agentName,
            overview: property.overview,
            price: property.price,
            image: property.image,
            rating: data['rating'],
            totalReviews: data['count'],
          );
        }),
      );

      emit(PropertyLoaded(
          properties:
              //properties
              propertiesWithRating));
    } catch (e) {
      emit(PropertyFailure(e.toString()));
    }
  }

  Future<Map<String, dynamic>> getAverageRatingAndCount(
      String apartmentId) async {
    try {
      var ratingsRef = FirebaseFirestore.instance
          .collection('Apartments')
          .doc(apartmentId)
          .collection('Ratings');

      var snapshot = await ratingsRef.get();

      if (snapshot.docs.isEmpty) {
        return {'rating': 0.0, 'count': 0};
      }

      double totalRating = 0;
      int count = snapshot.docs.length;

      snapshot.docs.forEach((doc) {
        totalRating += doc['ratingValue'];
      });

      double averageRating = totalRating / count;

      return {'rating': averageRating, 'count': count};
    } catch (e) {
      print('Error calculating rating and count: $e');
      return {'rating': 0.0, 'count': 0};
    }
  }
}
