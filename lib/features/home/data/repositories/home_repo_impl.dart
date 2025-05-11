import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homix/features/authentication/data/datasources/remote_data_sources/auth_remote_data_source.dart';
import 'package:homix/features/authentication/domain/entities/user_entity.dart';
import 'package:homix/features/authentication/domain/repositories/auth_repo.dart';
import 'package:homix/features/home/data/datasources/remote_data_sources/home_remote_data_source.dart';
import 'package:homix/features/home/domain/entities/property_entity.dart';
import 'package:homix/features/home/domain/repositories/home_repo.dart';



class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImpl({required this.homeRemoteDataSource});

  @override
  Future<List<PropertyEntity>> getProperty() 
  => homeRemoteDataSource.getProperty();

 
    
 

 
  

    
}