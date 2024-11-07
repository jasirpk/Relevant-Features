import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum MenuOptions {
  navigationDelgate,
  userAgent;
}

class Menu extends StatefulWidget {
  final WebViewController controller;
  const Menu({super.key, required this.controller});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuOptions>(
      onSelected: (value) async {
        switch (value) {
          case MenuOptions.navigationDelgate:
            await widget.controller.loadRequest(
              Uri.parse('https://youtube.com'),
            );
          case MenuOptions.userAgent:
            final userAgent = await widget.controller
                .runJavaScriptReturningResult('navigator.userAgent');
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$userAgent'),
              ),
            );
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<MenuOptions>(
          value: MenuOptions.navigationDelgate,
          child: Text('Navigate to YouTube'),
        ),
        PopupMenuItem<MenuOptions>(
          value: MenuOptions.userAgent,
          child: Text('Show user-agent'),
        ),
      ],
    );
  }
}
