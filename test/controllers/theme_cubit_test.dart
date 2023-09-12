import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:locus/src/controllers/theme/theme_cubit.dart';
import 'package:locus/src/models/theme.dart';
import 'package:mocktail/mocktail.dart';

/// Mock Storage class for testing Hydrated behavior of [ThemeCubit]
class MockStorage extends Mock implements Storage {}

void main() {
  late Storage storage;

  group('ThemeCubit', () {
    // Setup
    setUp(() {
      storage = MockStorage();

      // Configure expected outputs to exiting methods to check required functionality
      when(
        () => storage.write(any<String>(), any<dynamic>()),
      ).thenAnswer(
        (_) async => {},
      );

      when(
        () => storage.read(any<String>()),
      ).thenAnswer(
        (_) async => {},
      );

      when(
        () => storage.delete(any<String>()),
      ).thenAnswer(
        (_) async => {},
      );

      when(
        () => storage.clear(),
      ).thenAnswer(
        (_) async => {},
      );

      HydratedBloc.storage = storage;
    });

    test('Changes theme on toggle', () {
      final themeCubit = ThemeCubit();
      expect(themeCubit.state, LocusTheme(ThemeType.light));
      themeCubit.toggleTheme();
      expect(themeCubit.state, LocusTheme(ThemeType.dark));
    });

    test('Persists theme on toggle', () {
      final themeCubit = ThemeCubit();
      expect(themeCubit.state, LocusTheme(ThemeType.light));
      themeCubit.toggleTheme();
      expect(themeCubit.state, LocusTheme(ThemeType.dark));
      final expectedValue = {'type': 'dark'};
      verify(
        () => storage.write(
          "${themeCubit.storagePrefix}${themeCubit.id}",
          expectedValue,
        ),
      ).called(1);
    });

    test('Reads persisted theme on toggle and on instantiation', () {
      final themeCubit = ThemeCubit();
      verify(() => storage.read(themeCubit.storageToken)).called(1);
      expect(themeCubit.state, LocusTheme(ThemeType.light));
      themeCubit.toggleTheme();
      expect(themeCubit.state, LocusTheme(ThemeType.dark));
      final expectedValue = {'type': 'dark'};
      verify(
        () => storage.write(
          themeCubit.storageToken,
          expectedValue,
        ),
      ).called(1);
    });
  });
}
