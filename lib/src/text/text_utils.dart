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

/// Some string extensions
extension EasyString on String {
  /// Check 'starts with' for multiple conditions
  bool startsWithMultiple(List<String> substrings) {
    for (int i = 0; i < substrings.length; i++) {
      if (startsWith(substrings[i])) {
        return true;
      }
    }

    return false;
  }

  /// Check equality of other String but ignoring the case
  bool equalsIgnoreCase(String? other) {
    // https://stackoverflow.com/a/54180384
    return toLowerCase() == other?.toLowerCase();
  }

  /// Returns indexes of a char
  ///
  /// Warning: Do not use separators with multiple characters
  ///
  /// Example:
  /// ```dart
  /// var myStr = 'hello,from,dart';
  /// var indexes = myStr.indexesOf(',');
  /// ```
  List<int> indexesOf(String char) {
    assert(char.length == 1);

    List<int> out = [];

    for (int i = 0; i < length; i++) {
      if (this[i] == char) {
        if (i > 0 && this[i - 1] == r'\') {
          continue;
        }

        out.add(i);
      }
    }

    return out;
  }

  /// Returns a String list which contains parts of this String seperated by a seperator
  ///
  /// Warning: Do not use separators with multiple characters
  List<String> splitExtended(String sep, [int? index]) {
    var indexes = indexesOf(sep);

    if (index == null) {
      var out = <String>[];
      for (int i = 0; i < indexes.length; i++) {
        var index = i == 0 ? 0 : (indexes[i - 1] + 1);
        out.add(substring(index, indexes[i]));
      }

      return out;
    }

    assert(index > 0);
    index -= 1;

    return indexes.length <= index
        ? [this]
        : [substring(0, indexes[index]), substring(indexes[index] + 1)];
  }

  /// Whether this string is empty when all whitespaces trimmed.
  bool get isTrimEmpty => trim().isEmpty;

  /// Whether this string is empty when leading whitespaces trimmed.
  bool get isTrimLeftEmpty => trimLeft().isEmpty;

  /// Whether this string is empty when trailing whitespaces trimmed.
  bool get isTrimRightEmpty => trimRight().isEmpty;

  /// Whether this string is not empty when all whitespaces trimmed.
  bool get isTrimNotEmpty => !isTrimEmpty;

  /// Whether this string is not empty when leading whitespaces trimmed.
  bool get isTrimLeftNotEmpty => !isTrimLeftEmpty;

  /// Whether this string is not empty when trailing whitespaces trimmed.
  bool get isTrimRightNotEmpty => !isTrimRightEmpty;
}
