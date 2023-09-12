// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocusTheme _$LocusThemeFromJson(Map<String, dynamic> json) => LocusTheme(
      $enumDecode(_$ThemeTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$LocusThemeToJson(LocusTheme instance) =>
    <String, dynamic>{
      'type': _$ThemeTypeEnumMap[instance.type]!,
    };

const _$ThemeTypeEnumMap = {
  ThemeType.light: 'light',
  ThemeType.dark: 'dark',
};
