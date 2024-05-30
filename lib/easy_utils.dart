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

/// Some utilities to make your Flutter experience easier and better.
library easy_utils;

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'src/platform/platform_utils.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as http_parser;

export 'src/platform/platform_utils.dart';

part 'src/display/display_utils.dart';
part 'src/navigation/nav_utils.dart';
part 'src/navigation/custom_page_route.dart';
part 'src/navigation/page_route_type.dart';
part 'src/navigation/route_settings.dart';
part 'src/network/http_utils.dart';
part 'src/network/json_response.dart';
part 'src/text/text_utils.dart';
