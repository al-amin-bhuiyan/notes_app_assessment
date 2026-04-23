import 'package:notes_app_assessment/features/auth/domain/entities/user_entity.dart';
import 'package:notes_app_assessment/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase({required AuthRepository repository})
      : _repository = repository;

  Future<UserEntity> execute({
    required String name,
    required String email,
    required String password,
  }) {
    return _repository.register(name: name, email: email, password: password);
  }
}
