import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'custom_dialog.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      height: 100,
      alignment: Alignment.center,
      child: SizedBox(
        width: 40,
        height: 40,
        child: CircularProgressIndicator(),
      ),
    );
  }

  static Future<T?> show<T>(
    BuildContext context, {
    required AsyncValueGetter<T> future,
    VoidCallback? onSuccess,
    void Function(T)? onError,
  }) {
    return showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: false,
      builder: (context) {
        final call = future.call();
        call.then(
          (value) {
            Navigator.pop(context);
            onSuccess?.call();
          },
          onError: (err) async {
            Navigator.pop(context);
            onError?.call(err);
          },
        );
        return WillPopScope(
          onWillPop: () async => false,
          child: const LoadingDialog(),
        );
      },
    );
  }
}
