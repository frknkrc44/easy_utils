import 'package:flutter/material.dart';
import 'package:easy_utils/easy_utils.dart';

void main() => runApp(const MyMaterialApp());

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: EasyNav.materialAppKey,
      navigatorKey: EasyNav.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Easy Utils Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MaterialHomePage(),
    );
  }
}

// ignore: must_be_immutable
class MaterialHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            (EasyNav.materialAppKey.currentWidget as MaterialApp).title,
          ),
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
              ],
            ),
          ),
        ),
      );

  List<Widget> _navigationUtils = [
    Text('Navigator Utils'),
    SizedBox(height: 16),
    ElevatedButton(
      onPressed: () => EasyNav.push(
        MaterialSecondPage(),
        routeType: PageRouteType.DEFAULT_APP, /* Default value */
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

  List<Widget> _httpUtils = [
    Text('HTTP Utils'),
    SizedBox(height: 16),
    ElevatedButton(
      onPressed: () => EasyNav.push(MaterialHTTPPage()),
      child: Text('Open HTTP page'),
    ),
  ];
}

class MaterialSecondPage extends StatelessWidget {
  const MaterialSecondPage();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Second page'),
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
              Text('Example second page'),
            ],
          ),
        ),
      );
}

class MaterialHTTPPage extends StatefulWidget {
  const MaterialHTTPPage();

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
