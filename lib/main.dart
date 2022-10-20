import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() async {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    color: Colors.black,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String _url = "https://web.whatsapp.com/\uD83C\uDF10/it";
  final String _userAgent =
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36';
  final flutterWebviewPlugin = FlutterWebviewPlugin();

  bool isEnabled = false;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebPage(url: _url, userAgent: _userAgent, flutterWebviewPlugin: flutterWebviewPlugin,),
    );
  }
}



class WebPage extends StatelessWidget {
  const WebPage({
    Key? key,
    required String url,
    required String userAgent, required this.flutterWebviewPlugin,
  })  : _url = url,
        _userAgent = userAgent,
        super(key: key);
  final FlutterWebviewPlugin flutterWebviewPlugin;
  final String _url;
  final String _userAgent;

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appCacheEnabled: true,
      
      url: _url,
      userAgent: _userAgent,
      withJavascript: true,
      withZoom: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('WhatsApp Web Tab'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  flutterWebviewPlugin.reloadUrl(_url);
                }),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(Icons.cancel_outlined),
              onPressed: () {
                
                flutterWebviewPlugin.cleanCookies();
                flutterWebviewPlugin.clearCache();
                flutterWebviewPlugin.reloadUrl(_url);
              },
            ),
          )
        ],
      ),
    );
  }
}
