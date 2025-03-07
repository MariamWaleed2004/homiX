import 'package:homix/features/authentication/domain/entities/user_entity.dart';
import 'package:homix/features/authentication/domain/repositories/auth_repo.dart';

class SignUpUserUsecase {
  final AuthRepo repository;

  SignUpUserUsecase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.signUpUser(user);
  }
}