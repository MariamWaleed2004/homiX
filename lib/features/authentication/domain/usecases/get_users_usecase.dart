import 'package:homix/features/authentication/domain/entities/user_entity.dart';
import 'package:homix/features/authentication/domain/repositories/auth_repo.dart';

class GetUsersUsecase {
  final AuthRepo repository;

  GetUsersUsecase({required this.repository});

  Stream<List<UserEntity>> call(UserEntity user) {
    return repository.getUsers(user);
  }
}