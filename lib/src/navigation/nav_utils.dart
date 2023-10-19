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
/// ```dart
/// EasyNav.push(MyPage());
/// ```
class EasyNav {
  EasyNav._();

  static var navigatorKey = GlobalKey<NavigatorState>();
  static var materialAppKey = GlobalKey<State<MaterialApp>>();
  static var cupertinoAppKey = GlobalKey<State<CupertinoApp>>();
  static NavigatorState get _navigatorState => navigatorKey.currentState!;
  static BuildContext get _navigatorContext => navigatorKey.currentContext!;

  static const _notConnectedStateError =
      'Not connected to the MaterialApp/CupertinoApp state. Use "key: EasyNav.materialAppKey" for the MaterialApp or use "key: EasyNav.cupertinoAppKey" for the CupertinoApp to connect.';
  static const _notConnectedNavError =
      'Not connected to the MaterialApp/CupertinoApp navigator. Use "navigatorKey: EasyNav.navigatorKey" to connect.';

  /// Pop the current screen if canPop() returned true.
  ///
  /// You can send a result to receive from the back state.
  static void pop<T>([T? result]) {
    if (_navigatorState.canPop()) {
      return _navigatorState.pop<T>(result);
    }
  }

  /// Pop routes until it's the first one.
  static void popUntilFirst() => _navigatorState.popUntil((r) => r.isFirst);

  /// Push a route.
  static Future<T?> push<T>(
    Widget screen, {
    PageRouteType? routeType,
    String? routeName,
    dynamic arguments,
  }) {
    assert(_navigatorState.mounted, _notConnectedNavError);

    return _navigatorState.push<T>(
      _getPageRoute<T>(
        screen,
        routeType,
        routeName: routeName,
        arguments: arguments,
      ),
    );
  }

  /// Push a route and remove other ones.
  static Future<T?> replace<T>(
    Widget screen, {
    PageRouteType? routeType,
    String? routeName,
    dynamic arguments,
  }) =>
      replaceUntil<T>(
        screen,
        routeType: routeType,
        routeName: routeName,
        arguments: arguments,
        predicate: (r) => false,
      );

  /// Push a route and remove other ones until the condition returns true.
  static Future<T?> replaceUntil<T>(
    Widget screen, {
    PageRouteType? routeType,
    String? routeName,
    dynamic arguments,
    required bool Function(Route) predicate,
  }) {
    assert(_navigatorState.mounted, _notConnectedNavError);

    return _navigatorState.pushAndRemoveUntil<T>(
      _getPageRoute<T>(
        screen,
        routeType,
        routeName: routeName,
        arguments: arguments,
      ),
      predicate,
    );
  }

  /// Push a named route.
  static Future<T?> pushNamed<T>(
    String routeName, {
    PageRouteType? routeType,
    dynamic arguments,
  }) =>
      push<T>(
        _getRouteWidget(routeName),
        routeType: routeType,
        routeName: routeName,
        arguments: arguments,
      );

  /// Push a named route and remove other ones.
  static Future<T?> replaceNamed<T>(
    String routeName, {
    PageRouteType? routeType,
    dynamic arguments,
  }) =>
      replaceNamedUntil<T>(
        routeName,
        routeType: routeType,
        arguments: arguments,
        predicate: (r) => false,
      );

  /// Push a named route and remove other ones until the condition returns true.
  static Future<T?> replaceNamedUntil<T>(
    String routeName, {
    PageRouteType? routeType,
    dynamic arguments,
    required bool Function(Route) predicate,
  }) =>
      replaceUntil<T>(
        _getRouteWidget(routeName),
        routeType: routeType,
        routeName: routeName,
        arguments: arguments,
        predicate: predicate,
      );

  /// Get a route widget from a MaterialApp/CupertinoApp.
  static Widget _getRouteWidget(String name) {
    var routes = _getRoutes();

    assert(
      routes?.containsKey(name) ?? false,
      'Route "$name" is not found in the routes list.',
    );

    return routes![name]!(_navigatorContext);
  }

  /// Get routes list from a MaterialApp/CupertinoApp.
  static Map<String, Widget Function(BuildContext)>? _getRoutes() {
    assert(_navigatorState.mounted, _notConnectedNavError);

    if (materialAppKey.currentWidget != null) {
      return (materialAppKey.currentWidget as MaterialApp).routes;
    }

    if (cupertinoAppKey.currentWidget != null) {
      return (cupertinoAppKey.currentWidget as CupertinoApp).routes;
    }

    throw AssertionError(_notConnectedStateError);
  }

  /// Get the page route with a transition effect.
  static PageRoute<T> _getPageRoute<T>(
    Widget screen,
    PageRouteType? routeType, {
    String? routeName,
    dynamic arguments,
  }) {
    switch (routeType) {
      case PageRouteType.MATERIAL:
        return MaterialPageRoute<T>(
          builder: (_) => screen,
          settings: RouteSettings(
            name: routeName,
            arguments: arguments,
          ),
        );
      case PageRouteType.CUPERTINO:
        return CupertinoPageRoute<T>(
          builder: (_) => screen,
          settings: RouteSettings(
            name: routeName,
            arguments: arguments,
          ),
        );
      case PageRouteType.FADE:
      case PageRouteType.SLIDE:
        return _CustomPageRoute<T>(
          screen,
          routeType: routeType!,
          routeName: routeName,
          arguments: arguments,
        );
      case PageRouteType.DEFAULT_OS:
        var type = kIsWeb || !(Platform.isIOS || Platform.isMacOS)
            ? PageRouteType.MATERIAL
            : PageRouteType.CUPERTINO;

        return _getPageRoute<T>(
          screen,
          type,
          routeName: routeName,
          arguments: arguments,
        );
      case PageRouteType.DEFAULT_APP:
      default:
        assert(
          materialAppKey.currentWidget != null ||
              cupertinoAppKey.currentWidget != null,
          _notConnectedStateError,
        );

        var type = materialAppKey.currentWidget != null
            ? PageRouteType.MATERIAL
            : PageRouteType.CUPERTINO;

        return _getPageRoute<T>(
          screen,
          type,
          routeName: routeName,
          arguments: arguments,
        );
    }
  }
}