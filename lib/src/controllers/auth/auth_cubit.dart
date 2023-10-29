import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../models/locus_user.dart';
import '../../services/auth_service.dart';
import 'auth_state.dart';

/// A Cubit to handle all Authentication-related events
class AuthCubit extends Cubit<AuthState> {
  /// Authentication service - wraps the authentication logic into simple methods
  final AuthService authService;

  /// Used to store the LocusUser (if not null)
  final FlutterSecureStorage localStorage;

  /// The Cubit depends on the AuthService (structured as such for testing)
  /// and has a Loading state as its initial state
  AuthCubit(
    this.authService,
    this.localStorage,
  ) : super(LoadingAuthState());

  /// FlutterSecureStorage's user and page key
  static const _userKey = "user";

  /// Logs a User in (and saves them locally)
  Future<void> loginViaEmail(String email, String password) async {
    emit(LoadingAuthState());
    final user = await authService.loginViaEmail(email, password);
    if (user == null) {
      localStorage.write(key: _userKey, value: null);
      emit(const ErrorAuthState("Invalid credentials"));
    } else {
      localStorage.write(
        key: _userKey,
        value: jsonEncode(user.toJson()),
      );
      emit(LoadedAuthState(user));
    }
  }

  /// Logs a User in (and saves them locally)
  Future<void> loginViaUsername(String username, String password) async {
    emit(LoadingAuthState());
    final user = await authService.loginViaUsername(username, password);
    if (user == null) {
      localStorage.write(key: _userKey, value: null);
      emit(const ErrorAuthState("Invalid credentials"));
    } else {
      localStorage.write(
        key: _userKey,
        value: jsonEncode(user.toJson()),
      );
      emit(LoadedAuthState(user));
    }
  }

  Future<void> checkAuthStatus() async {
    try {
      final userJson = await localStorage.read(key: _userKey);
      final user =
          userJson == null ? null : LocusUser.fromJson(jsonDecode(userJson));
      emit(LoadedAuthState(user));
    } catch (e) {
      emit(ErrorAuthState(e.toString()));
    }
  }

  Future<void> loginViaGoogle() async {
    try {
      emit(LoadingAuthState());
      final googleUser = await authService.loginViaGoogle();
      if (googleUser != null) {
        final locusUser = await authService.getLocusUserFromOAuth(
          googleUser.email!,
        );
        localStorage.write(
          key: _userKey,
          value: jsonEncode(locusUser.toJson()),
        );
        emit(LoadedAuthState(locusUser));
      }
    } catch (e) {
      emit(ErrorAuthState(e.toString()));
    }
  }

  Future<void> signUp(
    String email,
    String password,
  ) async {
    try {
      emit(LoadingAuthState());
      final user = await authService.signUp(
        email,
        password,
      );
      if (user != null) {
        final userVal = LocusUser(
          user.uid,
          user.email!,
          user.displayName ?? "",
          "",
        );
        localStorage.write(key: _userKey, value: jsonEncode(userVal.toJson()));
        emit(LoadedAuthState(userVal));
      }
    } catch (e) {
      emit(ErrorAuthState(e.toString()));
    }
  }

  /// Sends an Email with a token
  /// If the user enters it successfully, they are signed up
  /// Else, no
  Future<void> sendVerificationLink() async {
    try {
      final user =
          (state is LoadedAuthState) ? (state as LoadedAuthState).user : null;
      emit(LoadingAuthState());
      await authService.sendVerificationLink();
      emit(LoadedAuthState(
        user,
      ));
    } catch (e) {
      emit(const ErrorAuthState("Invalid token"));
    }
  }

  /// Checks if a username exists
  Future<bool> checkIfUsernameExists(String username) async {
    return await authService.checkIfUsernameExists(username);
  }

  /// Updates a User's Name and Username
  Future<void> updateUsernameAndName(
    String email,
    String username,
    String name,
  ) async {
    try {
      final user =
          (state is LoadedAuthState) ? (state as LoadedAuthState).user : null;
      emit(LoadingAuthState());
      await authService.updateUsernameAndName(email, username, name);
      final locusUser = LocusUser(username, email, name, user?.bioData ?? "");
      localStorage.write(key: _userKey, value: jsonEncode(locusUser.toJson()));
      emit(LoadedAuthState(locusUser));
    } catch (e) {
      emit(ErrorAuthState(e.toString()));
    }
  }

  /// Check's if a User has verified their email
  Future<bool> checkIfEmailVerified() async {
    return authService.checkIfEmailVerified();
  }

  /// Resend's the email verification link
  Future<void> resendVerificationLink() async {
    await authService.resendVerificationLink();
  }

  /// Sends the password reset email
  Future<void> sendResetPasswordEmail(String email) async {
    try {
      emit(LoadingAuthState());
      await authService.sendResetPasswordEmail(email);
      emit(SuccessPasswordResetState());
    } catch (e) {
      emit(FailurePasswordResetState(e.toString()));
    }
  }

  /// Logs a user out
  Future<void> logOut() async {
    localStorage.write(key: _userKey, value: null);
    await authService.logOut();
  }
}
