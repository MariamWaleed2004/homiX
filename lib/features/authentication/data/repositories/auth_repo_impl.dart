import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homix/features/authentication/data/datasources/remote_data_sources/auth_remote_data_source.dart';
import 'package:homix/features/authentication/domain/entities/user_entity.dart';
import 'package:homix/features/authentication/domain/repositories/auth_repo.dart';



class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepoImpl({required this.authRemoteDataSource});

  @override
  Future<bool> isSignIn() async 
  => authRemoteDataSource.isSignIn();

  @override
  Future<void> signInUser(UserEntity user, BuildContext context) async
  => authRemoteDataSource.signInUser(user, context);

  @override
  Future<void> signOut() async
  => authRemoteDataSource.signOut();

  @override
  Future<void> signUpUser(UserEntity user, BuildContext context) async
  => authRemoteDataSource.signUpUser(user, context);

  @override
  Future<void> createUser(UserEntity user) async 
  => authRemoteDataSource.createUser(user);

  @override
  Future<String> getCurrentUid() async
  => authRemoteDataSource.getCurrentUid();

    @override
  Future<String> uploadImageToStorage(File? file, bool isPost, String childName) async 
  => authRemoteDataSource.uploadImageToStorage(file, isPost, childName);
  
  @override
  Stream<List<UserEntity>> getSingleUser(String uid) 
  => authRemoteDataSource.getSingleUser(uid);
  
  
  @override
  Stream<List<UserEntity>> getUsers(UserEntity user) 
  => authRemoteDataSource.getUsers(user);
  
  @override
  Future<void> updateUser(UserEntity user) async 
  => authRemoteDataSource.updateUser(user);

  @override
  Future<UserCredential?> signUpWithGoogle(BuildContext context) async
  => authRemoteDataSource.signUpWithGoogle(context);

    @override
  Future<UserCredential?> signInWithGoogle(BuildContext context) async
  => authRemoteDataSource.signInWithGoogle(context);
  
  

    
}