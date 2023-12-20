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

/// Use the MediaQuery and other device/screen related features easily.
class EasyDisplay {
  /// Constructor of EasyDisplay
  EasyDisplay._({required this.mediaQuery});

  /// Returns the current media query data
  final MediaQueryData mediaQuery;

  /// Creates an EasyDisplay object from EasyNav's appContext
  factory EasyDisplay.createFromAppContext() =>
      EasyDisplay.create(EasyNav.appContext);

  /// Creates an EasyDisplay object from EasyNav's focusContext
  factory EasyDisplay.createFromFocusContext() =>
      EasyDisplay.create(EasyNav.focusContext);

  /// Creates an EasyDisplay object with or without BuildContext
  factory EasyDisplay.create([BuildContext? context]) {
    return EasyDisplay._(
      mediaQuery: context != null
          ? MediaQuery.of(context)
          : MediaQueryData.fromView(EasyDisplay._refView),
    );
  }

  /// Returns the current platform brightness
  Brightness get platformBrightness => mediaQuery.platformBrightness;

  /// Whether the current platform brightness is dark
  bool get isDark => platformBrightness == Brightness.dark;

  /// Returns the size from the media query
  Size get size => mediaQuery.size;

  /// Returns the width from the media query
  double get width => size.width;

  /// Returns the height from the media query
  double get height => size.height;

  /// Whether the device is a tablet
  bool get isTablet {
    if (!isWeb) {
      if (isAndroid) return size.shortestSide >= 590;
      var diagonal = sqrt((width * width) + (height * height));
      return diagonal > 1100.0;
    }
    return false;
  }

  /// Returns a reference view object from the system views
  static FlutterView get _refView {
    var views = _dispatcher.views;

    if (views.isEmpty) {
      return _dispatcher.implicitView ??
          window; // ignore: deprecated_member_use
    }

    return views.first;
  }

  /// Returns a PlatformDispatcher instance for a shortcut
  static PlatformDispatcher get _dispatcher =>
      WidgetsBinding.instance.platformDispatcher;

  /// Returns display sizes
  static List<Size> get physicalsizes =>
      _dispatcher.displays.map<Size>((e) => e.size).toList();

  /// Returns the first display's size
  static Size get physicalSize => physicalsizes.first;

  /// Returns the first display's width
  static double get physicalWidth => physicalSize.width;

  /// Returns the first display's height
  static double get physicalHeight => physicalSize.height;
}
