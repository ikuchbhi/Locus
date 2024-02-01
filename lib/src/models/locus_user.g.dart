// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locus_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocusUser _$LocusUserFromJson(Map<String, dynamic> json) => LocusUser(
      json['username'] as String,
      json['emailAddress'] as String,
      json['name'] as String,
      json['bioData'] as String,
    );

Map<String, dynamic> _$LocusUserToJson(LocusUser instance) => <String, dynamic>{
      'username': instance.username,
      'emailAddress': instance.emailAddress,
      'name': instance.name,
      'bioData': instance.bioData,
    };
