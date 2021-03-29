import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    required this.child,
    double? height,
    AlignmentGeometry? alignment,
  })  : height = height ?? 300.0,
        alignment = alignment ?? Alignment.center,
        super(key: key);

  final Widget child;
  final double height;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Container(
        height: height,
        alignment: alignment,
        child: child,
      ),
    );
  }

  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    double? height,
    bool dismissible = false,
    WillPopCallback? onWillPop,
  }) {
    return showDialog<T>(
      context: context,
      useSafeArea: true,
      barrierDismissible: dismissible,
      builder: (_) => WillPopScope(
        onWillPop: onWillPop,
        child: CustomDialog(
          height: height,
          child: child,
        ),
      ),
    );
  }
}
