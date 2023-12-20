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

/// Use the Navigator without context.
///
/// ```dart
/// EasyNav.push(MyPage());
/// ```
class EasyNav {
  EasyNav._();

  /// Override the default DEFAULT_APP type to whatever you want.
  static PageRouteType? overriddenDefaultRouteType;

  /// Required Navigator key for the MaterialApp/CupertinoApp.
  static final navigatorKey = GlobalKey<NavigatorState>();

  /// Required key for the MaterialApp/CupertinoApp (used for named routes, `appContext` and `PageRouteType.DEFAULT_APP`).
  static final appKey = GlobalKey<State>();

  /// Returns BuildContext from the Navigator.
  static BuildContext get context => navigatorKey.currentContext!;

  /// Returns BuildContext from the app state.
  ///
  /// <b>NOTE:</b> Make sure you added the appKey to the app.
  static BuildContext? get appContext {
    assert(
      _isAppKeyValid,
      _notConnectedStateError,
    );

    return appKey.currentContext;
  }

  /// Returns BuildContext from the current focused child.
  static BuildContext? get focusContext =>
      FocusScope.of(context).focusedChild?.context;

  /// Returns state from the Navigator.
  static NavigatorState get state {
    assert(
      navigatorKey.currentState?.mounted ?? false,
      _notConnectedNavError,
    );

    return navigatorKey.currentState!;
  }

  /// Returns OverlayState from the Navigator.
  static OverlayState get overlay => state.overlay!;

  /// The constant error message when the app key is not added to an app.
  static const _notConnectedStateError =
      'Not connected to the MaterialApp/CupertinoApp state. Add "key: EasyNav.appKey" to connect.';

  /// The constant error message when the Navigator key is not added to an app.
  static const _notConnectedNavError =
      'Not connected to the MaterialApp/CupertinoApp navigator. Add "navigatorKey: EasyNav.navigatorKey" to connect.';

  /// Pop the current screen if canPop() returned true.
  ///
  /// You can send a result to receive from the back state.
  static void pop<T>([T? result]) {
    if (state.canPop()) {
      return state.pop<T>(result);
    }
  }

  /// Pop routes until it's the first one.
  static void popUntilFirst() => popUntil((r) => r.isFirst);

  /// Pop all routes (<b>use it carefully</b>).
  static void popAll() => popUntil((r) => false);

  /// Pop routes until the condition returns true.
  static void popUntil(bool Function(Route) predicate) =>
      state.popUntil(predicate);

  /// Push a route.
  ///
  /// [screen] The widget contains new screen layouts.<br>
  /// [routeType] See [PageRouteType] enum for more details.<br>
  /// [routeName] The route name (visible for Flutter Web).<br>
  /// [arguments] The arguments you passed to the new route.<br>
  /// [invisibleName] Make the route name invisible for the Route stack.<br>
  static Future<T?> push<T>(
    Widget screen, {
    PageRouteType? routeType,
    String? routeName,
    dynamic arguments,
    bool invisibleName = false,
  }) =>
      Future.delayed(
        Duration.zero,
        () => state.push<T>(
          _getPageRoute<T>(
            screen,
            routeType,
            routeName: routeName,
            arguments: arguments,
            invisibleName: invisibleName,
          ),
        ),
      );

  /// Push a route and remove other ones.
  ///
  /// [screen] The widget contains new screen layouts.<br>
  /// [routeType] See [PageRouteType] enum for more details.<br>
  /// [routeName] The route name (visible for Flutter Web).<br>
  /// [arguments] The arguments you passed to the new route.<br>
  /// [invisibleName] Make the route name invisible for the Route stack.<br>
  static Future<T?> replace<T>(
    Widget screen, {
    PageRouteType? routeType,
    String? routeName,
    dynamic arguments,
    bool invisibleName = false,
  }) =>
      replaceUntil<T>(
        screen,
        routeType: routeType,
        routeName: routeName,
        arguments: arguments,
        predicate: (r) => false,
        invisibleName: invisibleName,
      );

  /// Push a route and remove other ones until the condition returns true.
  ///
  /// [screen] The widget contains new screen layouts.<br>
  /// [routeType] See [PageRouteType] enum for more details.<br>
  /// [routeName] The route name (visible for Flutter Web).<br>
  /// [arguments] The arguments you passed to the new route.<br>
  /// [predicate] Pop routes until the condition returns true.<br>
  /// [invisibleName] Make the route name invisible for the Route stack.<br>
  static Future<T?> replaceUntil<T>(
    Widget screen, {
    PageRouteType? routeType,
    String? routeName,
    dynamic arguments,
    required bool Function(Route) predicate,
    bool invisibleName = false,
  }) =>
      Future.delayed(
        Duration.zero,
        () => state.pushAndRemoveUntil<T>(
          _getPageRoute<T>(
            screen,
            routeType,
            routeName: routeName,
            arguments: arguments,
            invisibleName: invisibleName,
          ),
          predicate,
        ),
      );

  /// Push a named route.
  ///
  /// [routeName] The route name (visible for Flutter Web).<br>
  /// [routeType] See [PageRouteType] enum for more details.<br>
  /// [arguments] The arguments you passed to the new route.<br>
  /// [invisibleName] Make the route name invisible for the Route stack.<br>
  static Future<T?> pushNamed<T>(
    String routeName, {
    PageRouteType? routeType,
    dynamic arguments,
    bool invisibleName = false,
  }) =>
      push<T>(
        _getRouteWidget(routeName),
        routeType: routeType,
        routeName: routeName,
        arguments: arguments,
        invisibleName: invisibleName,
      );

  /// Push a named route and remove other ones.
  ///
  /// [routeName] The route name (visible for Flutter Web).<br>
  /// [routeType] See [PageRouteType] enum for more details.<br>
  /// [arguments] The arguments you passed to the new route.<br>
  /// [invisibleName] Make the route name invisible for the Route stack.<br>
  static Future<T?> replaceNamed<T>(
    String routeName, {
    PageRouteType? routeType,
    dynamic arguments,
    bool invisibleName = false,
  }) =>
      replaceNamedUntil<T>(
        routeName,
        routeType: routeType,
        arguments: arguments,
        predicate: (r) => false,
        invisibleName: invisibleName,
      );

  /// Push a named route and remove other ones until the condition returns true.
  ///
  /// [routeName] The route name (visible for Flutter Web).<br>
  /// [routeType] See [PageRouteType] enum for more details.<br>
  /// [arguments] The arguments you passed to the new route.<br>
  /// [predicate] Pop routes until the condition returns true.<br>
  /// [invisibleName] Make the route name invisible for the Route stack.<br>
  static Future<T?> replaceNamedUntil<T>(
    String routeName, {
    PageRouteType? routeType,
    dynamic arguments,
    required bool Function(Route) predicate,
    bool invisibleName = false,
  }) =>
      replaceUntil<T>(
        _getRouteWidget(routeName),
        routeType: routeType,
        routeName: routeName,
        arguments: arguments,
        predicate: predicate,
        invisibleName: invisibleName,
      );

  /// Get the current route settings
  static RouteSettings? getCurrentRouteSettings([BuildContext? context]) =>
      ModalRoute.of(context ?? focusContext!)?.settings;

  /// Get the current route name
  static String getCurrentRouteName([BuildContext? context]) {
    var settings = getCurrentRouteSettings(context);

    if (settings is RouteSettingsExt && settings.realName != null) {
      return settings.realName!;
    }

    return settings?.name ?? '/';
  }

  /// Get the current route arguments
  static dynamic getCurrentRouteArguments([BuildContext? context]) =>
      getCurrentRouteSettings(context)?.arguments;

  /// Get a route widget from a MaterialApp/CupertinoApp.
  static Widget _getRouteWidget(String name) {
    var routes = _getRoutes();

    assert(
      routes?.containsKey(name) ?? false,
      'Route "$name" is not found in the routes list.',
    );

    return routes![name]!(context);
  }

  /// Get routes list from a MaterialApp/CupertinoApp.
  static Map<String, Widget Function(BuildContext)>? _getRoutes() {
    assert(state.mounted, _notConnectedNavError);

    // If the MaterialApp connection found, return routes list.
    if (appKey.currentWidget is MaterialApp) {
      return (appKey.currentWidget as MaterialApp).routes;
    }

    // If the CupertinoApp connection found, return routes list.
    if (appKey.currentWidget is CupertinoApp) {
      return (appKey.currentWidget as CupertinoApp).routes;
    }

    // Otherwise it throws an exception.
    throw AssertionError(_notConnectedStateError);
  }

  /// Whether the app key is implemented to app
  static bool get _isAppKeyValid =>
      appKey.currentWidget is MaterialApp ||
      appKey.currentWidget is CupertinoApp;

  /// Get the page route with a transition effect.
  static PageRoute<T> _getPageRoute<T>(
    Widget screen,
    PageRouteType? routeType, {
    String? routeName,
    dynamic arguments,
    bool invisibleName = false,
  }) {
    // If no custom route type defined,
    // use the overridden route type
    // or the default one.
    routeType ??= overriddenDefaultRouteType;

    switch (routeType) {
      case PageRouteType.MATERIAL:
        return MaterialPageRoute<T>(
          builder: (_) => screen,
          settings: RouteSettingsExt(
            name: invisibleName ? null : routeName,
            arguments: arguments,
            realName: routeName,
          ),
        );
      case PageRouteType.CUPERTINO:
        return CupertinoPageRoute<T>(
          builder: (_) => screen,
          settings: RouteSettingsExt(
            name: invisibleName ? null : routeName,
            arguments: arguments,
            realName: routeName,
          ),
        );
      case PageRouteType.FADE:
      case PageRouteType.SLIDE:
        return _CustomPageRoute<T>(
          screen,
          routeType: routeType!,
          routeName: routeName,
          arguments: arguments,
          invisibleName: invisibleName,
        );
      case PageRouteType.DEFAULT_OS:
        // Check for the current OS is iOS/macOS or not
        // Then select a possible page route type for the current OS
        var type = isApple ? PageRouteType.CUPERTINO : PageRouteType.MATERIAL;

        return _getPageRoute<T>(
          screen,
          type,
          routeName: routeName,
          arguments: arguments,
          invisibleName: invisibleName,
        );
      case PageRouteType.DEFAULT_APP:
      default:
        assert(
          _isAppKeyValid,
          _notConnectedStateError,
        );

        // Check the app uses MaterialApp or not
        // Then select a possible page route type for the current app configuration
        var type = appKey.currentWidget is MaterialApp
            ? PageRouteType.MATERIAL
            : PageRouteType.CUPERTINO;

        return _getPageRoute<T>(
          screen,
          type,
          routeName: routeName,
          arguments: arguments,
          invisibleName: invisibleName,
        );
    }
  }
}
