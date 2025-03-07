import 'package:homix/features/authentication/domain/entities/user_entity.dart';
import 'package:homix/features/authentication/domain/repositories/auth_repo.dart';

class CreateUserUsecase {
  final AuthRepo repository;

  CreateUserUsecase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.createUser(user);
  }
}