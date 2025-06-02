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

/// The route settings implementation for invisible routes.
class RouteSettingsExt extends RouteSettings {
  /// Route name (it's useful if the [name] declared as `null` due to `invisible: true`).
  final String? realName;

  /// Data that might be useful in constructing a [Route].
  const RouteSettingsExt({
    super.name,
    super.arguments,
    this.realName,
  });
}
