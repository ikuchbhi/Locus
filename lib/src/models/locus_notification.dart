import 'locus_user.dart';

/// In app notifications
///
/// Triggered when one user does an action, such as:
/// * posting in a Domain
/// * tagging a user
///
class LocusNotification {
  /// The user that caused the notification to trigger
  final LocusUser actionCause;

  /// The user that receieves the notification
  final LocusUser actionReceiver;

  /// When the notification was triggered
  final DateTime timestamp;

  /// The content of the notification
  final String content;

  /// The status - if it has been viewed or not
  final bool viewed;

  LocusNotification(
    this.actionCause,
    this.actionReceiver,
    this.timestamp,
    this.content, {
    this.viewed = false,
  });
}
