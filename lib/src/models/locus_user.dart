
import 'package:json_annotation/json_annotation.dart';

part 'locus_user.g.dart';

@JsonSerializable()
/// A Locus User
class LocusUser {
  /// A unique alphanumeric string used to identify users 
  final String username;

  /// A unique email address
  /// Same as the one used during registration and for any future contact
  final String emailAddress;

  /// The User's name
  final String name;

  /// A supporting body of text in which the User can give more information about their account
  final String bioData;

  // Constructor
  LocusUser(this.username, this.emailAddress, this.name, this.bioData);

  /// Converts a LocusUser to JSON
  Map<String, dynamic> toJson() => _$LocusUserToJson(this);

  /// Converts a JSON representation of a LocusUser to its Dart class
  factory LocusUser.fromJson(Map<String, dynamic> json) => _$LocusUserFromJson(json);
}