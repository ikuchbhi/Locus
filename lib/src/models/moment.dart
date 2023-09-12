import 'content.dart';
import 'location.dart';
import 'locus_user.dart';

/// A Locus [Moment]
///
/// Analogous to an Instagram Post or a Twitter Tweet
/// This is a base class, which all specialised types of [Moment]s must extend
abstract class Moment {
  final String momentId;
  final DateTime createdAt;
  final LocusUser creator;
  final Location location;

  Moment(this.createdAt, this.creator, this.location, this.momentId);
}

/// A simple [Moment], containing:
/// * a location (required)
/// * content (required)
class SimpleMoment implements Moment {
  @override
  final Location location;

  final Content content;

  SimpleMoment(
    this.momentId,
    this.creator,
    this.createdAt, {
    required this.location,
    required this.content,
  });

  @override
  final DateTime createdAt;

  @override
  final LocusUser creator;

  @override
  final String momentId;
}

/// A [CollectionMoment]
/// It can have upto 10 [Moment]s inside it
class CollectionMoment implements Moment {
  @override
  final Location location;

  @override
  final String momentId;

  @override
  final LocusUser creator;

  @override
  final DateTime createdAt;

  final List<Content> momentContents;

  CollectionMoment(
    this.momentId,
    this.creator,
    this.createdAt, {
    required this.location,
    required this.momentContents,
  });
}
