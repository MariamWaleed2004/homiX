import 'package:homix/features/favorites/domain/repositories/favorites_repo.dart';

class ToggleFavoritesUsecase {
  final FavoritesRepo repository;

  ToggleFavoritesUsecase({required this.repository});

  Future<void> call(String userId, String propertyId) {
    return repository.toggleFavorites(userId, propertyId);
  }
}