import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../models/theme.dart';

///
class ThemeCubit extends HydratedCubit<LocusTheme> {
  ThemeCubit() : super(LocusTheme(ThemeType.light));

  @override
  LocusTheme? fromJson(Map<String, dynamic> json) => LocusTheme.fromJson(json);

  @override
  Map<String, dynamic>? toJson(LocusTheme state) => state.toJson();

  // Changes theme
  void toggleTheme() {
    if(state.type == ThemeType.light) {
      emit(LocusTheme(ThemeType.dark));
    } else {
      emit(LocusTheme(ThemeType.light));
    }
  }
}