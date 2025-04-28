import 'package:homix/features/home/domain/entities/property_entity.dart';


abstract class HomeRepo {

  Future<List<PropertyEntity>> getApartment();



}