import 'package:notes_app_assessment/core/services/auth_service.dart';
import 'package:notes_app_assessment/features/auth/data/models/user_model.dart';
import 'package:notes_app_assessment/features/auth/domain/entities/user_entity.dart';
import 'package:notes_app_assessment/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl({required AuthService authService})
      : _authService = authService;

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final credential = await _authService.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel.fromFirebaseUser(credential.user!).toEntity();
  }

  @override
  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _authService.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _authService.updateDisplayName(name);
    return UserModel.fromFirebaseUser(credential.user!).toEntity();
  }

  @override
  Future<void> logout() async {
    await _authService.signOut();
  }
}
