import 'dart:io';

import 'package:homix/features/authentication/domain/entities/user_entity.dart';

abstract class AuthRepo {

  Future<void> signInUser(UserEntity user);

  Future<void> signUpUser(UserEntity user);
  
  Future<bool> isSignIn();

  Future<void> signOut(); 





  Future<void> createUser(UserEntity user);

  Future<void> updateUser(UserEntity user);

  Future<String> getCurrentUid();

  Future<String> uploadImageToStorage(File? file, bool isPost, String childName);

  Stream<List<UserEntity>> getUsers(UserEntity user);

  Stream<List<UserEntity>> getSingleUser(String uid);
}