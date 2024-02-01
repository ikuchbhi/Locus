import 'package:equatable/equatable.dart';

import '../../models/locus_user.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

class LoadingSettingsState extends SettingsState {}

class LoadedSettingsState extends SettingsState {
  final LocusUser locusUser;

  const LoadedSettingsState(this.locusUser);

  @override
  List<Object?> get props => [locusUser];
}

class ErrorSettingsState extends SettingsState {
  final String error;

  const ErrorSettingsState(this.error);

  @override
  List<Object?> get props => [error];
}