import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebView extends StatefulWidget {
  const CustomWebView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  final Completer<WebViewController> _completer =
  Completer<WebViewController>();
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("webview flutter 的使用"),
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: "http://192.168.1.15:9000/doc.html",
          onWebViewCreated: (WebViewController webViewController) {
            _completer.complete(webViewController);
            _controller = webViewController;
            print("webview be created/webview 被创建 $webViewController");
          },
          onPageStarted: (String url) {
            print("web view page started/ web view 开始加载 --->>> url:$url");
          },
          onPageFinished: (String url) {
            print("web view page finished / web view 结束加载 --->>> url:$url");
            _controller
                .evaluateJavascript("document.title")
                .then((value) => print(value));

            _controller.runJavascript("document.title").then((result) {
              print("runJavascript ");
            }).catchError((error){
              print("error info :${error.toString()}");
            });
          },
          onProgress: (int progress) {
            print("web view loading progress :$progress");
          },
          onWebResourceError: (WebResourceError error) {
            print("web view on web resource error :${error.description}");
          },
          navigationDelegate: (NavigationRequest navigation) {
            print("navigation delegate $navigation");
            return NavigationDecision.navigate;
          },
          javascriptChannels: <JavascriptChannel>{
            _channel(context),
          },
          javascriptMode: JavascriptMode.unrestricted,
          zoomEnabled: true,
        ),
      ),
    );
  }

  JavascriptChannel _channel(BuildContext context) {
    return JavascriptChannel(
        name: "toaster",
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('js ${message.message}')));
        });
  }
}
