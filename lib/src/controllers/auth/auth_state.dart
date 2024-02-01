import 'package:equatable/equatable.dart';
import 'package:locus/src/models/locus_user.dart';

/// A representative AuthState class
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Represents a Loading state
class LoadingAuthState extends AuthState {}

/// Represents a Loaded State
/// Requires a LocusUser as a parameter
/// If null, the user is logged out
/// Else, the user is logged in
class LoadedAuthState extends AuthState {
  final LocusUser? user;
  
  const LoadedAuthState(this.user);

  @override
  List<Object?> get props => [user];
}

/// Represents an Error state
class ErrorAuthState extends AuthState {
  final String error;

  const ErrorAuthState(this.error);

  @override
  List<Object?> get props => [error];
}

// For password resetting
class SuccessPasswordResetState extends AuthState {}

class FailurePasswordResetState extends AuthState {
  final String error;

  const FailurePasswordResetState(this.error);
  
  @override
  List<Object?> get props => [error];
}
