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

enum PageRouteType {
  /// Use the best one for the current app configuration (default)
  /// MaterialApp: Material transition
  /// CupertinoApp: Cupertino transition
  DEFAULT_APP,

  /// Use the best one for the current OS
  /// iOS/macOS: Cupertino transition
  /// Other platforms: Material transition
  DEFAULT_OS,

  /// Force the Material transition
  MATERIAL,

  /// Force the Cupertino transition
  CUPERTINO,

  /// Use custom fade transition
  FADE,

  /// Use custom slide transition
  SLIDE,
}
