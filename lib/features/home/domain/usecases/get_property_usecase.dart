import 'package:homix/features/home/domain/entities/property_entity.dart';
import 'package:homix/features/home/domain/repositories/home_repo.dart';

class GetPropertyUsecase {
  final HomeRepo repository;

  GetPropertyUsecase({required this.repository});

  Future<List<PropertyEntity>> call() {
    return repository.getProperty();
  }
}