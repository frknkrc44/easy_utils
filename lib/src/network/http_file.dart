part of '../../easy_utils.dart';

/// Holds the multipart form data files.
class HttpFile {
  final String name;
  final Uint8List bytes;
  final String mimeType;
  final int length;

  HttpFile({
    required this.name,
    required this.bytes,
    required this.mimeType,
    required this.length,
  });

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

  http.MultipartFile asMultipartFile(String field) =>
      http.MultipartFile.fromBytes(
        field,
        bytes,
        filename: name,
        contentType: http_parser.MediaType.parse(mimeType),
      );
}
