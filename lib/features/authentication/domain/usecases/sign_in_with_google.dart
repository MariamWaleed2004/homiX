import 'package:firebase_auth/firebase_auth.dart';
import 'package:homix/features/authentication/domain/entities/user_entity.dart';
import 'package:homix/features/authentication/domain/repositories/auth_repo.dart';

class SignInWithGoogleUsecase {
  final AuthRepo repository;

  SignInWithGoogleUsecase({required this.repository});

  Future<UserCredential?> call() {
    return repository.signInWithGoogle();
  }
}