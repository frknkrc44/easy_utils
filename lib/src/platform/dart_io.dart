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

import 'dart:io';

/// Whether the operating system is a version of Android.
bool get isAndroid => Platform.isAndroid;

/// Whether the operating system is a version of Fuchsia.
bool get isFuchsia => Platform.isFuchsia;

/// Whether the operating system is a version of iOS.
bool get isIOS => Platform.isIOS;

/// Whether the operating system is a version of Linux.
bool get isLinux => Platform.isLinux;

/// Whether the operating system is a version of macOS.
bool get isMacOS => Platform.isMacOS;

/// Whether the operating system is a version of Windows.
bool get isWindows => Platform.isWindows;

/// Whether the environment is Web.
bool get isWeb => false;
