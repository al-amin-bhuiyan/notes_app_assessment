import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.name,
    required super.email,
  });

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
    );
  }

  UserEntity toEntity() {
    return UserEntity(uid: uid, name: name, email: email);
  }
}