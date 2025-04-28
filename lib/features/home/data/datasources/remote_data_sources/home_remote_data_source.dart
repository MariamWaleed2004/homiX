import 'package:homix/features/home/domain/entities/property_entity.dart';


abstract class HomeRemoteDataSource {

  Future<List<PropertyEntity>> getApartment();



}