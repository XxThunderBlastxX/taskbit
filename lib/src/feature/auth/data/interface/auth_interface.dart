import 'package:appwrite/models.dart';
import 'package:dartz/dartz.dart';

import '../../../../app/error/error.dart';

abstract class IAuth {
  Future<Failure?> signInWithGoogle();

  Future<Failure?> signOut();

  Future<Either<User, Failure>> getCurrentUser();

  Future<Either<Session, Failure>> getCurrentSession();
}
