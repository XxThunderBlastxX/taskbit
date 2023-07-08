import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/auth_repository.dart';
import '../states/login_state.dart';

final loginNotifierProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (StateNotifierProviderRef<LoginNotifier, LoginState> ref) => LoginNotifier(
    authRepository: ref.watch(authRepositoryProvider),
  ),
);

class LoginNotifier extends StateNotifier<LoginState> {
  late final AuthRepository _authRepository;

  LoginNotifier({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(LoginInitial());

  Future<void> signInUser() async {
    state = LoginLoading();
    final failure = await _authRepository.signInWithGoogle();

    if (failure == null) {
      state = LoginSuccess();
      return;
    } else {
      state = LoginError(failure: failure);
      return;
    }
  }
}
