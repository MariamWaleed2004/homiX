import 'package:homix/features/favorites/data/datasources/favorites_remote_data_source.dart';
import 'package:homix/features/favorites/domain/repositories/favorites_repo.dart';
import 'package:homix/features/home/data/models/property_model.dart';

class FavoritesRepoImpl  implements FavoritesRepo{
  final FavoritesRemoteDataSource favoritesRemoteDataSource;
  FavoritesRepoImpl({required this.favoritesRemoteDataSource});

  @override
  Future<void> toggleFavorites(String userId, String propertyId) async {
    await favoritesRemoteDataSource.toggleFavorites(userId, propertyId);
  }

  @override
  Future<List<PropertyModel>> getUserFavorites(String userId) async {
    return await favoritesRemoteDataSource.getUserFavorites(userId);
  }

}

