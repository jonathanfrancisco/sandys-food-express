import 'package:flutter/material.dart';

import 'loading_dialog.dart';

class ProgressHUD extends StatelessWidget {
  final Widget _child;
  final bool _inProgress;
  final double opacity;

  ProgressHUD({
    required Widget child,
    required bool inProgress,
    this.opacity = 0.7,
  })  : _child = child,
        _inProgress = inProgress;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(_child);

    if (_inProgress) {
      final modal = new Stack(
        children: [
          new Opacity(
            opacity: opacity,
            child: ModalBarrier(
              dismissible: false,
              color: Color(0xFF000000),
            ),
          ),
          Center(
            child: LoadingDialog(),
          ),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}
