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

class EasyNav {
  EasyNav._();

  static var navigatorKey = GlobalKey<NavigatorState>();
  static var materialAppKey = GlobalKey<State<MaterialApp>>();
  static var cupertinoAppKey = GlobalKey<State<CupertinoApp>>();
  static get _navigatorState => navigatorKey.currentState!;
  static get _navigatorContext => navigatorKey.currentContext!;

  static const _notConnectedStateError =
      'Not connected to the MaterialApp/CupertinoApp state. Use "key: EasyNav.materialAppKey" for the MaterialApp or use "key: EasyNav.cupertinoAppKey" for the CupertinoApp to connect.';
  static const _notConnectedNavError =
      'Not connected to the MaterialApp/CupertinoApp navigator. Use "navigatorKey: EasyNav.navigatorKey" to connect.';

  static void pop([dynamic result]) {
    if (_navigatorState.canPop()) {
      _navigatorState.pop(result);
    }
  }

  static Future<void> push(
    Widget screen, {
    PageRouteType? routeType,
    String? routeName,
    dynamic arguments,
  }) {
    assert(_navigatorState.mounted, _notConnectedNavError);

    return _navigatorState.push(
      _getPageRoute(
        screen,
        routeType,
        routeName: routeName,
        arguments: arguments,
      ),
    );
  }

  static Future<void> replace(
    Widget screen, {
    PageRouteType? routeType,
    String? routeName,
    dynamic arguments,
  }) =>
      replaceUntil(
        screen,
        routeType: routeType,
        routeName: routeName,
        arguments: arguments,
        predicate: (r) => false,
      );

  static Future<void> replaceUntil(
    Widget screen, {
    PageRouteType? routeType,
    String? routeName,
    dynamic arguments,
    required bool Function(Route) predicate,
  }) {
    assert(_navigatorState.mounted, _notConnectedNavError);

    return _navigatorState.pushAndRemoveUntil(
      _getPageRoute(
        screen,
        routeType,
        routeName: routeName,
        arguments: arguments,
      ),
      predicate,
    );
  }

  static Future<void> pushNamed(
    String routeName, {
    PageRouteType? routeType,
    dynamic arguments,
  }) =>
      push(
        _getRouteWidget(routeName),
        routeType: routeType,
        routeName: routeName,
        arguments: arguments,
      );

  static Future<void> replaceNamed(
    String routeName, {
    PageRouteType? routeType,
    dynamic arguments,
  }) =>
      replaceNamedUntil(
        routeName,
        routeType: routeType,
        arguments: arguments,
        predicate: (r) => false,
      );

  static Future<void> replaceNamedUntil(
    String routeName, {
    PageRouteType? routeType,
    dynamic arguments,
    required bool Function(Route) predicate,
  }) =>
      replaceUntil(
        _getRouteWidget(routeName),
        routeType: routeType,
        routeName: routeName,
        arguments: arguments,
        predicate: predicate,
      );

  static Widget _getRouteWidget(String name) {
    var routes = _getRoutes();

    assert(
      routes?.containsKey(name) ?? false,
      'Route "$name" is not found in the routes list.',
    );

    return routes![name]!(_navigatorContext);
  }

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

  static PageRoute _getPageRoute(
    Widget screen,
    PageRouteType? routeType, {
    String? routeName,
    dynamic arguments,
  }) {
    switch (routeType) {
      case PageRouteType.MATERIAL:
        return MaterialPageRoute(
          builder: (_) => screen,
          settings: RouteSettings(
            name: routeName,
            arguments: arguments,
          ),
        );
      case PageRouteType.CUPERTINO:
        return CupertinoPageRoute(
          builder: (_) => screen,
          settings: RouteSettings(
            name: routeName,
            arguments: arguments,
          ),
        );
      case PageRouteType.FADE:
      case PageRouteType.SLIDE:
        return _CustomPageRoute(
          screen,
          routeType: routeType!,
          routeName: routeName,
          arguments: arguments,
        );
      case PageRouteType.DEFAULT_OS:
        var type = kIsWeb || !(Platform.isIOS || Platform.isMacOS)
            ? PageRouteType.MATERIAL
            : PageRouteType.CUPERTINO;

        return _getPageRoute(
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

        return _getPageRoute(
          screen,
          type,
          routeName: routeName,
          arguments: arguments,
        );
    }
  }
}
