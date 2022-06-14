// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:window_size/window_size.dart';

/// sets and enforces window size
///
void setupWindow({
  required String title,
  required double windowHeight,
  required double windowWidth,
}) {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    setWindowTitle(title);

    setWindowMinSize(Size(windowWidth, windowHeight));
    setWindowMaxSize(Size(windowWidth, windowHeight));

    getCurrentScreen().then((screen) {
      setWindowFrame(
        Rect.fromCenter(
          center: screen!.frame.center,
          width: windowWidth,
          height: windowHeight,
        ),
      );
    });
  }
}

/// create and pop an [AlertDialog] with the given child as it's contents
///
void popAlert({
  required BuildContext context,
  required String title,
  required Widget child,
  bool dismissibleOnTap = false,
}) {
  showDialog(
    context: context,
    barrierDismissible: dismissibleOnTap,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: child,
    ),
  );
}
