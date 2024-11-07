import 'package:flutter/material.dart';
import 'package:flutter_demo/view/webview/menu.dart';
import 'package:flutter_demo/view/webview/navigation_controlls.dart';
import 'package:flutter_demo/view/webview/webview_stack.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({super.key});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  late final WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(Uri.parse('https://event-master-2bf93.web.app'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Flutter WebVeiw'),
          actions: [
            NavigationControlls(controller: controller),
            Menu(controller: controller)
          ],
        ),
        body: WebviewStack(
          controller: controller,
        ));
  }
}
