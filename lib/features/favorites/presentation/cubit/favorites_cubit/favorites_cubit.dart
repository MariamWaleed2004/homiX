import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homix/features/favorites/domain/usecases/get_user_favorites_usecase.dart';
import 'package:homix/features/favorites/domain/usecases/toggle_favorites_usecase.dart';
import 'package:homix/features/home/data/models/property_model.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final ToggleFavoritesUsecase toggleFavoritesUsecase;
  final GetUserFavoritesUsecase getUserFavoritesUsecase;

  FavoritesCubit({
    required this.getUserFavoritesUsecase,
    required this.toggleFavoritesUsecase,
  }) : super(FavoritesInitial());

  List<String> favoriteIds = [];

  Future<void> loadFavorites(String userId) async {
    emit(FavoritesLoading());

    try {
      final favorites = await getUserFavoritesUsecase.call(userId);
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesFailure(e.toString()));
    }
  }

  Future<void> toggleFavorites(String userId, String propertyId) async {
    try {
      await toggleFavoritesUsecase.call(userId, propertyId);
      await loadFavorites(userId);
    } catch (e) {
      emit(FavoritesFailure(e.toString()));
    }
  }
}

