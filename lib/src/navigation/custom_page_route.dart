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

class _CustomPageRoute<T> extends PageRouteBuilder<T> {
  _CustomPageRoute(
    Widget route, {
    String? routeName,
    dynamic arguments,
    required PageRouteType routeType,
  }) : super(
          settings: RouteSettings(
            name: routeName,
            arguments: arguments,
          ),
          pageBuilder: (
            context,
            animation,
            secondaryAnimation,
          ) =>
              route,
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) {
            switch (routeType) {
              case PageRouteType.FADE:
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              case PageRouteType.SLIDE:
              default:
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.fastLinearToSlowEaseIn;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: tween.animate(animation),
                  child: child,
                );
            }
          },
        );
}
