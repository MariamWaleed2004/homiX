// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:homix/features/favorites/data/datasources/favorites_remote_data_source.dart';
// import 'package:homix/features/favorites/domain/usecases/get_user_favorites_usecase.dart';
// import 'package:homix/features/favorites/domain/usecases/toggle_favorites_usecase.dart';
// import 'package:homix/features/home/data/models/property_model.dart';
// import 'package:meta/meta.dart';

// part 'favorites_state.dart';

// class FavoritesCubit extends Cubit<FavoritesState> {
//   final GetUserFavoritesUsecase getUserFavoritesUsecase;
//   final ToggleFavoritesUsecase toggleFavoritesUsecase;

//   FavoritesCubit({
//     required this.getUserFavoritesUsecase,
//     required this.toggleFavoritesUsecase,
//   }) : super(FavoritesInitial());

//   Future<void> loadFavorites(String userId) async {
//     emit(FavoritesLoading());
//     try {
//       final favorites = await getUserFavoritesUsecase(userId);
//       emit(FavoritesLoaded(favorites));
//     } catch (e) {
//       emit(FavoritesFailure(e.toString()));
//     }
//   }

//   // Future<void> toggleFavoriteStatus(String userId, String propertyId) async {
//   //   try {
//   //     await toggleFavoritesUsecase(userId, propertyId);
//   //     await loadFavorites(userId);
//   //   } catch (e) {
//   //     emit(FavoritesFailure(e.toString()));
//   //   }
//   // }

//   //In your toggleFavoriteStatus method in FavoritesCubit
// Future<void> toggleFavoriteStatus(String userId, String propertyId) async {
//   try {
//     print('Toggling favorite for property $propertyId');
//     await toggleFavoritesUsecase(userId, propertyId);
//     print('Favorite toggled, loading updated favorites');
//     await loadFavorites(userId);
//     print('Favorites reloaded');
//   } catch (e) {
//     print('Error toggling favorite: $e');
//     emit(FavoritesFailure(e.toString()));
//   }
// }

// }

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:homix/features/favorites/data/datasources/favorites_remote_data_source.dart';
import 'package:homix/features/favorites/domain/usecases/get_user_favorites_usecase.dart';
import 'package:homix/features/favorites/domain/usecases/toggle_favorites_usecase.dart';
import 'package:homix/features/home/data/models/property_model.dart';
import 'package:homix/features/home/domain/entities/property_entity.dart';
import 'package:meta/meta.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final GetUserFavoritesUsecase getUserFavoritesUsecase;
  final ToggleFavoritesUsecase toggleFavoritesUsecase;

  FavoritesCubit({
    required this.getUserFavoritesUsecase,
    required this.toggleFavoritesUsecase,
  }) : super(FavoritesInitial());

  Future<void> loadFavorites(String userId) async {
    emit(FavoritesLoading());
    try {
      final favorites = await getUserFavoritesUsecase(userId);
      // print(
      //     "555555555555555555Favorites loaded from Firebase: ${favorites.map((e) => e.id)}");
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesFailure(e.toString()));
    }
  }




  Future<void> toggleFavoriteStatus(String userId, String propertyId) async {
    try {
      await toggleFavoritesUsecase(userId, propertyId);

      await loadFavorites(userId);
    } catch (e) {
      emit(FavoritesFailure(e.toString()));
    }
  }

  //  Future<void> toggleFavoriteStatus(
  //     String userId, PropertyModel property) async {
  //   try {
  //     final currentState = state;
  //     if (currentState is FavoritesLoaded) {
  //       final isCurrentlyFavorite =
  //           currentState.favorites.any((p) => p.id == property.id);

  //       // تحديث محلي سريع
  //       final updatedFavorites = isCurrentlyFavorite
  //           ? currentState.favorites
  //               .where((p) => p.id != property.id)
  //               .toList()
  //           : [...currentState.favorites, property];

  //       emit(FavoritesLoaded(updatedFavorites));

  //       // تنفيذ التعديل على Firestore في الخلفية
  //       await toggleFavoritesUsecase(userId, property.id);
  //     }
  //   } catch (e) {
  //     emit(FavoritesFailure(e.toString()));
  //   }
  // }

  // Future<void> toggleFavoriteStatus(String userId, String propertyId) async {
  //   try {
  //     final currentState = state;
  //     if (currentState is FavoritesLoaded) {
  //       final isCurrentlyFavorite =
  //           currentState.favorites.any((p) => p.id == propertyId);

  //       final propertyDoc = await FirebaseFirestore.instance
  //           .collection('Apartments')
  //           .doc(propertyId)
  //           .get();

  //       final fullProperty = PropertyModel.fromFirestore(propertyDoc);

  //       final updatedFavorites = isCurrentlyFavorite
  //           ? currentState.favorites.where((p) => p.id != propertyId).toList()
  //           : [...currentState.favorites, fullProperty];

  //       emit(FavoritesLoaded(updatedFavorites));

  //       await toggleFavoritesUsecase(userId, propertyId);

  //       //await loadFavorites(userId); // fallback
  //     }
  //   } catch (e) {
  //     emit(FavoritesFailure(e.toString()));
  //   }
  // }

// Future<void> toggleFavoriteStatus(String userId, String propertyId) async {
//   try {
//     final currentState = state;
//     if (currentState is FavoritesLoaded) {
//       final isCurrentlyFavorite = currentState.favorites.any((p) => p.id == propertyId);

//       // Toggle the favorite in the backend
//       await toggleFavoritesUsecase(userId, propertyId);

//       List<PropertyModel> updatedFavorites = List.from(currentState.favorites);

//       if (isCurrentlyFavorite) {
//         // Remove from local list
//         updatedFavorites.removeWhere((p) => p.id == propertyId);
//       } else {
//         // Add to local list — but we need full data
//         final doc = await FirebaseFirestore.instance
//             .collection('properties')
//             .doc(propertyId)
//             .get();
//         final property = PropertyModel.fromFirestore(doc);
//         updatedFavorites.add(property);
//       }

//       emit(FavoritesLoaded(updatedFavorites));
//     } else {
//       await loadFavorites(userId); // fallback
//     }
//   } catch (e) {
//     emit(FavoritesFailure(e.toString()));
//   }
// }
}
