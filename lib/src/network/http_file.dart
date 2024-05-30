part of '../../easy_utils.dart';

/// Holds the multipart form data files.
///
/// Example:
/// ```dart
/// final httpFile = HttpFile.fromNameAndBytes(
///   'file.png',
///   file.readAsBytesSync(),
///   'image/png',
/// );
/// final multipart = httpFile.asMultipartFile('photo');
/// ```
class HttpFile {
  /// The file name.
  final String name;

  /// The file bytes as [Uint8List].
  final Uint8List bytes;

  /// The content/mime type of the file.
  final String mimeType;

  /// The main constructor of the [HttpFile].
  HttpFile({
    required this.name,
    required this.bytes,
    required this.mimeType,
  });
  
  /// Export the [HttpFile] as the [http.MultipartFile].
  http.MultipartFile asMultipartFile(String field) =>
      http.MultipartFile.fromBytes(
        field,
        bytes,
        filename: name,
        contentType: http_parser.MediaType.parse(mimeType),
      );
}
