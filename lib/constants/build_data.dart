import 'package:flutter/foundation.dart';

abstract class BuildData {
  BuildData._();

  static bool get isDebugMode => kDebugMode;
  static bool get isReleaseMode => kReleaseMode;
}
