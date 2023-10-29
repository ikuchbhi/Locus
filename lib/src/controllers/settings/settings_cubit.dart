import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/settings_service.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsService settingsService;

  SettingsCubit(this.settingsService) : super(LoadingSettingsState());

  Future<void> getSettings(String email) async {
    try {
      emit(LoadingSettingsState());
      final locusUser = await settingsService.getSettings(email);
      emit(LoadedSettingsState(locusUser));
    } catch (e) {
      emit(ErrorSettingsState(e.toString()));
    }
  }

  Future<void> setUsername(String email, String username) async {
    try {
      emit(LoadingSettingsState());
      final user = await settingsService.updateUsername(email, username);
      emit(LoadedSettingsState(user));
    } catch (e) {
      emit(ErrorSettingsState(e.toString()));
    }
  }

  Future<void> setName(String email, String name) async {
    try {
      emit(LoadingSettingsState());
      final user = await settingsService.updateName(email, name);
      emit(LoadedSettingsState(user));
    } catch (e) {
      emit(ErrorSettingsState(e.toString()));
    }
  }

  Future<void> setBiodata(String email, String biodata) async {
    try {
      emit(LoadingSettingsState());
      final user = await settingsService.updateBiodata(email, biodata);
      emit(LoadedSettingsState(user));
    } catch (e) {
      emit(ErrorSettingsState(e.toString()));
    }
  }
}
