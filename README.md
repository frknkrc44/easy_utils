[![pub package](https://img.shields.io/pub/v/easy_utils.svg)](https://pub.dev/packages/easy_utils)
[![package publisher](https://img.shields.io/pub/publisher/easy_utils.svg)](https://pub.dev/packages/easy_utils/publisher)

A Flutter package which contains some helpful tools.

Just run `flutter pub add easy_utils` to add in your project.

## Features
- Send HTTP requests simply (uses http library as dependency).
- Manage the app navigation without context requirement.
- Check the current platform even you're compiling the same code for the Web platform.
- And more...

## EasyNav

### First steps

#### MaterialApp

Add EasyNav.navigatorKey and EasyNav.appKey to your MaterialApp instance.

```dart
  ...

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: EasyNav.appKey,
      navigatorKey: EasyNav.navigatorKey,

  ...
```

#### CupertinoApp

Add EasyNav.navigatorKey and EasyNav.appKey to your CupertinoApp instance.

```dart
  ...

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      key: EasyNav.appKey,
      navigatorKey: EasyNav.navigatorKey,

  ...
```

### Usage

Example: Push a new screen

```dart
EasyNav.push(const MyScreen());
```

Example: Push a new screen and pop others

```dart
EasyNav.replace(const MyScreen());
```

Example: Push a new screen and pop until the first one

```dart
EasyNav.replaceUntil(
  const MyScreen(),
  predicate: (route) => route.isFirst,
);
```

Example: Pop all screens until the first one

```dart
EasyNav.popUntilFirst();
```

Example: Pop the current screen

```dart
EasyNav.pop();
```

For more details, check the `src/navigation/nav_utils.dart` file.

## EasyHttp

No first step is required, use it directly.

### Supported HTTP methods

- GET
- HEAD
- POST
- PUT
- DELETE
- PATCH

NOTE: You can use another request type with sendCUSTOM method.

### Usage

Example: Send a GET request

```dart
EasyHttp.instance.sendGET('https://httpbin.org/get');
```

Example: Define an API prefix and send a GET request

```dart
EasyHttp.instance.prefix = 'https://httpbin.org';
EasyHttp.instance.sendGET('/get');
```

Example: Send a custom HTTP request

```dart
EasyHttp.instance.sendCUSTOM(
  'https://example.com/myRoute',
  method: 'PROPATCH',
);
```

For more details, check the `src/network/http_utils.dart` file.

## platform_utils

Check the running OS with a compatible way for the Web platform.

### Usage

Example: Check for the Android OS

```dart
...

// import the library
import 'package:easy_utils/easy_utils.dart' as EasyUtils;

if (EasyUtils.isAndroid) {
  // it will run when the device have the Android OS
  debugPrint('Hello from Android!');
}

...
```

For more details, check the `src/platform` folder.

## EasyDisplay

Check the display features with or without a BuildContext.

### Usage

Example: Check the physical display width

```dart
EasyDisplay.physicalWidth;
```

Example: Check the platform brightness by using a BuildContext

```dart
EasyDisplay.create(context).platformBrightness;
```

Example: Check for the dark mode enabled by using the EasyNav's appContext

```dart
if (EasyDisplay.createFromAppContext().isDark) {
  debugPrint('Dark mode');
}
```

For more details, check the `src/display/display_utils.dart` file.
