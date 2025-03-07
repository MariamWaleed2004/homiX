import 'dart:io';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? name;
  final String? email;
  final String? password;
  final String? confirmPassword;


  UserEntity({
    this.uid,
    this.name,
    this.email,
    this.password,
    this.confirmPassword,
  });

  @override
  List<Object?> get props => [
        uid,
        name,
        email,
        password,
        confirmPassword,
      ];
}
