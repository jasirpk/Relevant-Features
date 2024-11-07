import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavigationControlls extends StatelessWidget {
  final WebViewController controller;
  const NavigationControlls({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () async {
            final messenger = ScaffoldMessenger.of(context);
            if (await controller.canGoBack()) {
              await controller.goBack();
            } else {
              messenger.showSnackBar(
                  SnackBar(content: Text('No back History Item')));
              return;
            }
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        IconButton(
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              if (await controller.canGoForward()) {
                await controller.goForward();
              } else {
                messenger.showSnackBar(
                    SnackBar(content: Text('No Forward history item')));
                return;
              }
            },
            icon: Icon(Icons.arrow_forward_ios)),
        IconButton(
          onPressed: () {
            controller.reload();
          },
          icon: Icon(Icons.replay),
        )
      ],
    );
  }
}
