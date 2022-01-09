import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadAnimation extends StatelessWidget {
  const LoadAnimation({Key? key, required this.child}) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: child,
      baseColor: Colors.grey[500]!,
      highlightColor: Colors.grey[100]!,
      period: Duration(milliseconds: 1200),
    );
  }
}
