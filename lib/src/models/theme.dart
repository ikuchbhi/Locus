// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'theme.g.dart';

enum ThemeType { light, dark }

/// Stores both Dark and Light themes
@JsonSerializable()
class LocusTheme extends Equatable {
  final ThemeData theme;
  
  final ThemeType type;

  LocusTheme(this.type)
      : theme = type == ThemeType.dark ? _DARK_THEME : _LIGHT_THEME;

  factory LocusTheme.fromJson(Map<String, dynamic> json) => _$LocusThemeFromJson(json);

  Map<String, dynamic> toJson() => _$LocusThemeToJson(this);
  
  @override
  List<Object?> get props => [theme, type];
}

// Dark Theme
final _DARK_THEME = ThemeData(
  fontFamily: 'Aleo',
  primaryColor: const Color(0xFFFB8B24),
  colorScheme: ThemeData(brightness: Brightness.dark).colorScheme.copyWith(
        secondary: const Color(0xC40208FC),
        tertiary: const Color(0x40DADFF7),
        error: const Color(0xFFBB342F),
        //success color (not defined): Color(0xFF48BB78),
      ),
  useMaterial3: true,
);

// Light Theme
final _LIGHT_THEME = ThemeData(
  fontFamily: 'Aleo',
  primaryColor: const Color(0xFFFB8B24),
  colorScheme: ThemeData(brightness: Brightness.light).colorScheme.copyWith(
        secondary: const Color(0xC40208FC),
        tertiary: const Color(0x40DADFF7),
        error: const Color(0xFFBB342F),
        //success color (not defined): Color(0xFF48BB78),
      ),
  useMaterial3: true,
);
