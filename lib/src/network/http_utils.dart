/*
 *  This file is part of easy_utils.
 *
 *  easy_utils is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  easy_utils is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *   along with easy_utils.  If not, see <https://www.gnu.org/licenses/>.
 */

part of '../../easy_utils.dart';

/// Send a HTTP request and receive the output easily.
/// ```dart
/// EasyHttp.instance.sendGET('https://httpbin.org/get');
/// ```
///
/// You can add/override the HTTP headers by using the `headers` parameter.
/// ```dart
/// EasyHttp.instance.sendGET(
///   'https://httpbin.org/get',
///   headers: {
///     'User-Agent': 'EasyUtils/Demo',
///   },
/// );
/// ```
///
/// You can send a body data by using the `body` parameter (not available for GET and HEAD requests).
/// ```dart
/// EasyHttp.instance.sendPOST(
///   'https://httpbin.org/post',
///   body: {
///     'app_name': 'easy_utils',
///   },
/// );
/// ```
///
/// If you need to pass the body as the form data, just enable the `sendBodyAsForm` parameter.
/// </br><i>You have to set the </i>`body`<i> variable type as </i>`Map<String, String>`.
/// </br><b>Don't set the Content-Type header if you enabled the </b>`sendBodyAsForm`<b> parameter.</b>
///
/// ```dart
/// EasyHttp.instance.sendPOST(
///   'https://httpbin.org/post',
///   body: {
///     'app_name': 'easy_utils',
///   },
///   sendBodyAsForm: true,
/// );
/// ```
///
/// You can send a custom HTTP request (like UNLOCK) by using the `sendCUSTOM` or `sendCUSTOMStreamed` function's `method` parameter.
///
/// ```dart
/// EasyHttp.instance.sendCUSTOM(
///   'https://example.com/test',
///   method: 'UNLOCK',
/// );
/// ```
///
/// You can set an URL prefix to minify your URLs (useful for API requests).
/// </br>Set the `prefix` value as `null` to clear the custom prefix.
///
/// ```dart
/// EasyHttp.instance.prefix = 'https://httpbin.org';
/// EasyHttp.instance.sendGET('/get');
/// ```
///
/// Don't forget to allow the clear text traffic if you're using the HTTP communication instead of HTTPS.
class EasyHttp {
  /// Constructor of EasyHttp
  EasyHttp._();

  static EasyHttp? _instance;

  /// Get the EasyHttp instance
  static EasyHttp get instance => _instance ??= EasyHttp._();

  final _client = http.Client();

  /// Set a prefix to use it on your API calls.
  ///
  /// You can set it as `null` to cancel it.
  String? prefix;

  /// Send a GET request
  Future<http.Response> sendGET(
    String url, {
    Map<String, String>? headers,
    int timeout = 30000,
  }) async =>
      sendCUSTOM(
        url,
        method: 'GET',
        headers: headers,
        timeout: timeout,
      );

  /// Send a GET request as StreamedResponse
  Future<http.StreamedResponse> sendGETStreamed(
    String url, {
    Map<String, String>? headers,
    int timeout = 30000,
  }) async =>
      sendCUSTOMStreamed(
        url,
        method: 'GET',
        headers: headers,
        timeout: timeout,
      );

  /// Send a HEAD request
  Future<http.Response> sendHEAD(
    String url, {
    Map<String, String>? headers,
    int timeout = 30000,
  }) async =>
      sendCUSTOM(
        url,
        method: 'HEAD',
        headers: headers,
        timeout: timeout,
      );

  /// Send a HEAD request as StreamedResponse
  Future<http.StreamedResponse> sendHEADStreamed(
    String url, {
    Map<String, String>? headers,
    int timeout = 30000,
  }) async =>
      sendCUSTOMStreamed(
        url,
        method: 'HEAD',
        headers: headers,
        timeout: timeout,
      );

  /// Send a POST request
  Future<http.Response> sendPOST(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    int timeout = 30000,
    bool sendBodyAsForm = false,
  }) async =>
      sendCUSTOM(
        url,
        method: 'POST',
        headers: headers,
        body: body,
        encoding: encoding,
        timeout: timeout,
        sendBodyAsForm: sendBodyAsForm,
      );

  /// Send a POST request as StreamedResponse
  Future<http.StreamedResponse> sendPOSTStreamed(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    int timeout = 30000,
    bool sendBodyAsForm = false,
  }) async =>
      sendCUSTOMStreamed(
        url,
        method: 'POST',
        headers: headers,
        body: body,
        encoding: encoding,
        timeout: timeout,
        sendBodyAsForm: sendBodyAsForm,
      );

  /// Send a PUT request
  Future<http.Response> sendPUT(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    int timeout = 30000,
    bool sendBodyAsForm = false,
  }) async =>
      sendCUSTOM(
        url,
        method: 'PUT',
        headers: headers,
        body: body,
        encoding: encoding,
        timeout: timeout,
        sendBodyAsForm: sendBodyAsForm,
      );

  /// Send a PUT request as StreamedResponse
  Future<http.StreamedResponse> sendPUTStreamed(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    int timeout = 30000,
    bool sendBodyAsForm = false,
  }) async =>
      sendCUSTOMStreamed(
        url,
        method: 'PUT',
        headers: headers,
        body: body,
        encoding: encoding,
        timeout: timeout,
        sendBodyAsForm: sendBodyAsForm,
      );

  /// Send a DELETE request
  Future<http.Response> sendDELETE(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    int timeout = 30000,
    bool sendBodyAsForm = false,
  }) async =>
      sendCUSTOM(
        url,
        method: 'DELETE',
        headers: headers,
        body: body,
        encoding: encoding,
        timeout: timeout,
        sendBodyAsForm: sendBodyAsForm,
      );

  /// Send a DELETE request as StreamedResponse
  Future<http.StreamedResponse> sendDELETEStreamed(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    int timeout = 30000,
    bool sendBodyAsForm = false,
  }) async =>
      sendCUSTOMStreamed(
        url,
        method: 'DELETE',
        headers: headers,
        body: body,
        encoding: encoding,
        timeout: timeout,
        sendBodyAsForm: sendBodyAsForm,
      );

  /// Send a PATCH request
  Future<http.Response> sendPATCH(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    int timeout = 30000,
    bool sendBodyAsForm = false,
  }) async =>
      sendCUSTOM(
        url,
        method: 'PATCH',
        headers: headers,
        body: body,
        encoding: encoding,
        timeout: timeout,
        sendBodyAsForm: sendBodyAsForm,
      );

  /// Send a PATCH request as StreamedResponse
  Future<http.StreamedResponse> sendPATCHStreamed(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    int timeout = 30000,
    bool sendBodyAsForm = false,
  }) async =>
      sendCUSTOMStreamed(
        url,
        method: 'PATCH',
        headers: headers,
        body: body,
        encoding: encoding,
        timeout: timeout,
        sendBodyAsForm: sendBodyAsForm,
      );

  /// Send a custom HTTP request (like UNLOCK)
  Future<http.Response> sendCUSTOM(
    String url, {
    required String method,
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    int timeout = 30000,
    bool sendBodyAsForm = false,
  }) async {
    var streamedResponse = await sendCUSTOMStreamed(
      url,
      method: method,
      headers: headers,
      body: body,
      encoding: encoding,
      timeout: timeout,
      sendBodyAsForm: sendBodyAsForm,
    );

    var streamBytes = await streamedResponse.stream.toBytes();

    try {
      final returnedBody = (encoding ?? utf8).decode(streamBytes);
      return http.Response(
        returnedBody,
        streamedResponse.statusCode,
        request: streamedResponse.request,
        headers: streamedResponse.headers,
        isRedirect: streamedResponse.isRedirect,
        persistentConnection: streamedResponse.persistentConnection,
        reasonPhrase: streamedResponse.reasonPhrase,
      );
    } catch (e) {
      return http.Response.bytes(
        streamBytes,
        streamedResponse.statusCode,
        request: streamedResponse.request,
        headers: streamedResponse.headers,
        isRedirect: streamedResponse.isRedirect,
        persistentConnection: streamedResponse.persistentConnection,
        reasonPhrase: streamedResponse.reasonPhrase,
      );
    }
  }

  /// Send a custom HTTP request (like UNLOCK) as streamed
  Future<http.StreamedResponse> sendCUSTOMStreamed(
    String url, {
    required String method,
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    int timeout = 30000,
    bool sendBodyAsForm = false,
  }) async {
    if (!url.contains('://')) {
      if (prefix?.contains('://') ?? false) {
        if (prefix!.endsWith('/') && url.startsWith('/')) {
          url = '$prefix${url.substring(1)}';
        } else if (!(prefix!.endsWith('/') || url.startsWith('/'))) {
          url = '$prefix/$url';
        } else {
          url = '$prefix$url';
        }
      } else {
        throw AssertionError(
            'The URL doesn\'t contain http:// or https:// and the prefix is invalid.');
      }
    }

    final multiPartRequest = sendBodyAsForm && body is Map<String, dynamic>;

    var customRequest = multiPartRequest
        ? http.MultipartRequest(method, Uri.parse(url))
        : http.Request(method, Uri.parse(url));

    if (!multiPartRequest) {
      (customRequest as http.Request).encoding = encoding ?? utf8;
    }

    if (headers?.isNotEmpty ?? false) {
      customRequest.headers.addAll(
        headers!.map(
          // convert content-type to Content-Type
          (key, value) {
            var newKeyArr = key.split('-');

            for (int i = 0; i < newKeyArr.length; i++) {
              var item = newKeyArr[i];
              newKeyArr[i] =
                  item[0].toUpperCase() + item.substring(1).toLowerCase();
            }

            return MapEntry(newKeyArr.join('-'), value);
          },
        ),
      );
    }

    if (multiPartRequest) {
      final bodyMapKeys = body.keys.toList();

      for (int i = 0; i < body.length; i++) {
        final key = bodyMapKeys[i];
        final value = body[key];

        if (value is HttpFile) {
          (customRequest as http.MultipartRequest).files.add(
                value.asMultipartFile(key),
              );
        } else {
          (customRequest as http.MultipartRequest).fields[key] = value;
        }
      }
    } else {
      if (body != null) {
        if (body is Map) {
          if (sendBodyAsForm && body is Map<String, String>) {
            // remove the content type key to prevent errors
            if (customRequest.headers.containsKey('Content-Type')) {
              customRequest.headers.remove('Content-Type');
            }

            (customRequest as http.Request).bodyFields = body;
          } else {
            (customRequest as http.Request).body = jsonEncode(body);
          }
        } else if (body is List<int>) {
          (customRequest as http.Request).bodyBytes = body;
        } else {
          (customRequest as http.Request).body = body.toString();
        }
      }
    }

    var request = _client.send(customRequest);
    if (timeout <= 0) {
      return request;
    }

    return request.timeout(
      Duration(milliseconds: timeout),
    );
  }
}
