import 'package:notes_app_assessment/features/auth/domain/entities/user_entity.dart';
import 'package:notes_app_assessment/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase({required AuthRepository repository})
      : _repository = repository;

  Future<UserEntity> execute({
    required String email,
    required String password,
  }) {
    return _repository.login(email: email, password: password);
  }
}
