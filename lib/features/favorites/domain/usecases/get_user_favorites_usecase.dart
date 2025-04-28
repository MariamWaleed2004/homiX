import 'package:homix/features/favorites/domain/repositories/favorites_repo.dart';
import 'package:homix/features/home/data/models/property_model.dart';

class GetUserFavoritesUsecase {
  final FavoritesRepo repository;

  GetUserFavoritesUsecase({required this.repository});

  Future<List<PropertyModel>> call(String userId) async {
    return repository.getUserFavorites(userId);

  }
}
