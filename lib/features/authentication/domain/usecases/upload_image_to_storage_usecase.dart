import 'dart:io';
import 'package:homix/features/authentication/domain/repositories/auth_repo.dart';


class UploadImageToStorageUsecase {
  final AuthRepo repository;

  UploadImageToStorageUsecase({required this.repository});

  Future<String> call(File file, bool isPost, String childName) {
    return repository.uploadImageToStorage(file, isPost, childName);
  }
}