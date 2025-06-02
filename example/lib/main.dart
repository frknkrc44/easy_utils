import 'package:flutter/material.dart';
import 'package:easy_utils/easy_utils.dart';

void main() => runApp(const MyMaterialApp());

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: EasyNav.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Easy Utils Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (c) => MaterialHomePage(),
        '/second': (c) => MaterialSecondPage(),
      },
      initialRoute: '/',
    );
  }
}

class MaterialHomePage extends StatelessWidget {
  const MaterialHomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(EasyNav.appTitle),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ..._navigationUtils,
                SizedBox(height: 16),
                ..._httpUtils,
                SizedBox(height: 16),
                ..._getDisplayUtils(context),
                SizedBox(height: 16),
                ..._platformUtils,
              ],
            ),
          ),
        ),
      );

  List<Widget> get _navigationUtils => [
        Text('Navigator Utils'),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => EasyNav.pushNamed(
            '/second',
            // Default value
            routeType: PageRouteType.DEFAULT_APP,
            arguments: 'BLABLABLA',
            invisibleName: true,
          ),
          child: Text('Open second page (App class)'),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => EasyNav.push(
            MaterialSecondPage(),
            routeType: PageRouteType.DEFAULT_OS,
          ),
          child: Text('Open second page (OS)'),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => EasyNav.push(
            MaterialSecondPage(),
            routeType: PageRouteType.MATERIAL,
          ),
          child: Text('Open second page (Material)'),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => EasyNav.push(
            MaterialSecondPage(),
            routeType: PageRouteType.CUPERTINO,
          ),
          child: Text('Open second page (Cupertino)'),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => EasyNav.push(
            MaterialSecondPage(),
            routeType: PageRouteType.FADE,
          ),
          child: Text('Open second page (Fade)'),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => EasyNav.push(
            MaterialSecondPage(),
            routeType: PageRouteType.SLIDE,
          ),
          child: Text('Open second page (Slide)'),
        ),
      ];

  List<Widget> _getDisplayUtils(BuildContext context) => [
        Text('Display Utils'),
        SizedBox(height: 16),
        Text(
            'Physical size: ${EasyDisplay.physicalWidth}x${EasyDisplay.physicalHeight}'),
        Text('Media query size (context): ${_getMediaQuerySize(context)}'),
        Text(
            'Media query size (navContext): ${_getMediaQuerySize(EasyNav.context)}'),
        Text(
            'Media query size (appContext): ${_getMediaQuerySize(EasyNav.appContext)}'),
        Text(
            'Media query size (focusContext): ${_getMediaQuerySize(EasyNav.focusContext!)}'),
      ];

  String _getMediaQuerySize(BuildContext context) {
    var mediaQuerySize = EasyDisplay.create(context).mediaQuery.size;
    return '${mediaQuerySize.width}x${mediaQuerySize.height}';
  }

  List<Widget> get _httpUtils => [
        Text('HTTP Utils'),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => EasyNav.push(MaterialHTTPPage()),
          child: Text('Open HTTP page'),
        ),
      ];

  List<Widget> get _platformUtils => [
        Text('Platform Utils'),
        SizedBox(height: 16),
        Text('Apple: $isApple (iOS: $isIOS - macOS: $isMacOS)'),
        Text('Google: $isGoogle (Android: $isAndroid - Fuchsia: $isFuchsia)'),
        Text(
            'Desktop: $isDesktop (Linux: $isLinux - MacOS: $isMacOS - Windows: $isWindows)'),
        Text('Mobile: $isMobile (Android: $isAndroid - iOS: $isIOS)'),
        Text('Web: $isWeb'),
      ];
}

class MaterialSecondPage extends StatelessWidget {
  const MaterialSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    var routeName = EasyNav.getCurrentRouteName();
    var routeArgs = EasyNav.getCurrentRouteArguments();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Second page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Example second page'),
            Text('Route name: $routeName'),
            Text('Route args: $routeArgs'),
          ],
        ),
      ),
    );
  }
}

class MaterialHTTPPage extends StatefulWidget {
  const MaterialHTTPPage({super.key});

  @override
  State<MaterialHTTPPage> createState() => _MaterialHTTPPageState();
}

class _MaterialHTTPPageState extends State<MaterialHTTPPage> {
  @override
  void initState() {
    EasyHttp.instance.prefix = 'https://httpbin.org';
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('HTTP page'),
          leading: IconButton(
            onPressed: EasyNav.pop,
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder(
                future: EasyHttp.instance.sendPOST(
                  '/anything',
                  headers: {
                    'User-Agent': 'EasyUtils/Demo',
                    // don't use the Content-Type if you enable sendBodyAsForm
                    'Content-Type': 'application/json; charset=utf-8'
                  },
                  body: <String, String>{
                    'app_name': 'easy_utils',
                  },
                ),
                builder: (context, snapshot) => Text(
                  snapshot.data?.body ??
                      snapshot.error?.toString() ??
                      'Loading...',
                  style: TextStyle(fontFamily: 'monospace'),
                ),
              ),
            ],
          ),
        ),
      );
}
