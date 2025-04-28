import 'package:homix/features/home/domain/entities/property_entity.dart';
import 'package:homix/features/home/domain/repositories/home_repo.dart';

class GetApartmentUsecase {
  final HomeRepo repository;

  GetApartmentUsecase({required this.repository});

  Future<List<PropertyEntity>> call() {
    return repository.getApartment();
  }
}