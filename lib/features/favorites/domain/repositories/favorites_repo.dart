import 'package:homix/features/home/data/models/property_model.dart';

abstract class FavoritesRepo {

  Future<void> toggleFavorites(String userId, String propertyId);
  
  Future<List<PropertyModel>> getUserFavorites(String userId);
}
