import 'package:homix/features/authentication/domain/repositories/auth_repo.dart';

class SignOutUserUsecase {
  final AuthRepo repository;

  SignOutUserUsecase({required this.repository});

  Future<void> call() {
    return repository.signOut();
  }
}