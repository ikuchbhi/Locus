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

  /// FlutterSecureStorage's key
  static const _userKey = "user";

  /// Logs a User in (and saves them locally)
  Future<void> login(String email, String password) async {
    emit(LoadingAuthState());
    final user = await authService.login(email, password);
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

  Future<void> loginViaGoogle() async {
    try {
      emit(LoadingAuthState());
      final googleUser = await authService.loginViaGoogle();
      if (googleUser != null) {
        emit(
          LoadedAuthState(
            LocusUser(googleUser.email!, googleUser.email!, "", ""),
          ),
        );
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
      await authService.signUp(
        email,
        password,
      );
    } catch (e) {
      emit(ErrorAuthState(e.toString()));
    }
    emit(LoadedAuthState(LocusUser("", email, password, "")));
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
      emit(LoadedAuthState(user));
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
      emit(
        LoadedAuthState(
          LocusUser(username, email, name, user?.bioData ?? ""),
        ),
      );
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
}
