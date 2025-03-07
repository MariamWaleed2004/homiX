import 'package:homix/features/authentication/domain/repositories/auth_repo.dart';

class GetCurrentUidUsecase {
  final AuthRepo repository;

  GetCurrentUidUsecase({required this.repository});

  Future<String> call() {
    return repository.getCurrentUid();
  }
}