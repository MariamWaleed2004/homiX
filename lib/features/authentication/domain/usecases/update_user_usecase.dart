import 'package:homix/features/authentication/domain/entities/user_entity.dart';
import 'package:homix/features/authentication/domain/repositories/auth_repo.dart';

class UpdateUserUsecase {
  final AuthRepo repository;

  UpdateUserUsecase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.updateUser(user);
  }
}