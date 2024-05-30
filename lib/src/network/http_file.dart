part of '../../easy_utils.dart';

/// Holds the multipart form data files.
class HttpFile {
  /// The file name.
  final String name;

  /// The file bytes as Uint8List
  final Uint8List bytes;

  /// The content/mime type of the file.
  final String mimeType;

  /// The byte length of the file.
  final int length;

  /// The main constructor of the [HttpFile].
  HttpFile({
    required this.name,
    required this.bytes,
    required this.mimeType,
    required this.length,
  });

  /// Create a [HttpFile] instance without length.
  factory HttpFile.fromNameAndBytes(
    String name,
    Uint8List bytes,
    String mimeType,
  ) =>
      HttpFile(
        name: name,
        bytes: bytes,
        mimeType: mimeType,
        length: bytes.length,
      );

  /// Export the [HttpFile] as the [http.MultipartFile].
  http.MultipartFile asMultipartFile(String field) =>
      http.MultipartFile.fromBytes(
        field,
        bytes,
        filename: name,
        contentType: http_parser.MediaType.parse(mimeType),
      );
}
