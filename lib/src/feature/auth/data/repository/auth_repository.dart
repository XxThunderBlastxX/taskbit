import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/error/error.dart';
import '../../../../app/utils/utils.dart';
import '../../../../provider/provider.dart';
import '../interface/auth_interface.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(
    account: ref.watch(accountProvider),
    localStorage: ref.watch(localStorageProvider),
    log: ref.watch(styledLogProvider),
  ),
);

class AuthRepository implements IAuth {
  final Account _account;
  final LocalStorage _localStorage;
  final StyledLog _log;

  AuthRepository({
    required Account account,
    required LocalStorage localStorage,
    required StyledLog log,
  })  : _account = account,
        _localStorage = localStorage,
        _log = log;

  @override
  Future<Failure?> signInWithGoogle() async {
    try {
      _log.i("Signing in with Google...🐣");
      await _account.createOAuth2Session(provider: 'google');

      final User user = await _account.get();
      await _localStorage.write(key: 'email', value: user.email);
      await _localStorage.write(key: 'name', value: user.name);
      await _localStorage.write(key: 'id', value: user.$id);

      _log.i("Signed in with Google successfully 🎉");
      return null;
    } on AppwriteException catch (err) {
      _log.e(err.message ?? 'Something went wrong with sign in 😕');
      return Failure(
        message: err.message ?? 'Something went wrong',
        code: err.code,
      );
    } catch (err) {
      _log.e('$err ☹️');
      return Failure(message: err.toString().toUpperCase());
    }
  }

  @override
  Future<Failure?> signOut() async {
    try {
      _log.i("Signing out...👋");
      await _account.deleteSession(sessionId: 'current');

      await _localStorage.delete(key: 'email');
      await _localStorage.delete(key: 'name');
      await _localStorage.delete(key: 'id');

      _log.i("Signed out successfully 🎉");
      return null;
    } on AppwriteException catch (err) {
      _log.e(err.message ?? 'Something went wrong with sign out 😕');
      return Failure(
        message: err.message ?? 'Something went wrong',
        code: err.code,
      );
    } catch (err) {
      _log.e('$err ☹️');
      return Failure(message: err.toString().toUpperCase());
    }
  }

  @override
  Future<Either<Session, Failure>> getCurrentSession() async {
    try {
      _log.i('Getting current session...🐣');
      final Session session = await _account.getSession(sessionId: 'current');

      _log.i('Received current session successfully 🎉');
      return Left(session);
    } on AppwriteException catch (err) {
      _log.e(
          '${err.message ?? 'Something went wrong with getting session'} ☹️');
      return Right(
        Failure(
          message: err.message ?? 'Something went wrong',
          code: err.code,
        ),
      );
    } catch (err) {
      _log.e('$err ☹️');
      return Right(
        Failure(message: err.toString().toUpperCase()),
      );
    }
  }

  @override
  Future<Either<User, Failure>> getCurrentUser() async {
    try {
      _log.i('Getting current user...🐣');
      final User user = await _account.get();

      _log.i('Received current user successfully 🎉');
      return Left(user);
    } on AppwriteException catch (err) {
      _log.e('${err.message ?? 'Something went wrong with getting user'} ☹️');
      return Right(
        Failure(
          message: err.message ?? 'Something went wrong',
          code: err.code,
        ),
      );
    } catch (err) {
      _log.e('$err ☹️');
      return Right(
        Failure(message: err.toString().toUpperCase()),
      );
    }
  }
}
