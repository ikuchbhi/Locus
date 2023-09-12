/// Base [Content] class
/// 
/// Every specialised type of content must extend from this base class
abstract class Content {}

/// Plain text content
/// 
/// The default content for any [Moment]
class PlainTextContent extends Content {
  /// The plain text content
  final String content;

  PlainTextContent(this.content);
}

/// Image with optional caption content
/// 
/// Contains an image with an optional caption for any [Moment]
class ImageCaptionContent extends Content {
  /// The URL of the [Moment]'s image
  final String imageUrl;

  /// An optional caption
  final String caption;

  ImageCaptionContent({required this.imageUrl, this.caption = ""});
}