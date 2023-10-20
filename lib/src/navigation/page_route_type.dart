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
