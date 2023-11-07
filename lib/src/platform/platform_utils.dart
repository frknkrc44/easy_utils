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

import 'dart_html.dart' if (dart.library.io) 'dart_io.dart';

export 'dart_html.dart' if (dart.library.io) 'dart_io.dart';

/// Whether the operating system is a version of iOS or macOS.
bool get isApple => isIOS || isMacOS;

/// Whether the operating system is a version of Android or Fuchsia.
bool get isGoogle => isAndroid || isFuchsia;

/// Whether the operating system is a version of Linux, macOS or Windows.
bool get isDesktop => isLinux || isMacOS || isWindows;

/// Whether the operating system is a version of Android or iOS.
bool get isMobile => isAndroid || isIOS;
