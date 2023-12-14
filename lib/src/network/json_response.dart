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

part of easy_utils;

/// The JSON response extension for the HTTP library
extension JSONResponse on _http.Response {
  /// Converts the body content to `List` / `Map`
  dynamic get bodyJson => jsonDecode(body);

  /// Converts the body content to `List<T>`
  List<T> getBodyList<T>() => (bodyJson as List<dynamic>).cast<T>();

  /// Converts the body content to `Map<String, T>`
  Map<String, T> getBodyMap<T>() =>
      (bodyJson as Map<String, dynamic>).cast<String, T>();
}
