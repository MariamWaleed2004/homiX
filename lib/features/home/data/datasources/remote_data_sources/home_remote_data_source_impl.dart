import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homix/features/home/data/datasources/remote_data_sources/home_remote_data_source.dart';
import 'package:homix/features/home/data/models/property_model.dart';
import 'package:homix/features/home/domain/entities/property_entity.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  HomeRemoteDataSourceImpl({required this.firebaseFirestore});

  @override
  Future<List<PropertyEntity>> getProperty() async {
    final snapshot = await firebaseFirestore.collection('Apartments').get();
    return snapshot.docs
        .map((doc) => PropertyModel.fromMap(doc.data(), doc.id))
        .toList();
  }


}
