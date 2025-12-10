import 'package:dzevent/presentation/widgets/DesktopDraggableScroll.dart';
import 'package:flutter/material.dart';

class Refreshable extends StatelessWidget {
  final Widget child;
  final Future<bool> Function() refresh;
  const Refreshable({super.key, required this.refresh, required this.child});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: Desktopdraggablescroll(child: child),
    );
  }
}
