import 'dart:async';

import 'package:build/build.dart';

class LangKeysGenerator implements Builder {
  @override
  Map<String, List<String>> get buildExtensions => {
        '.json': ['lang_keys.dart'],
      };

  @override
  FutureOr<void> build(BuildStep buildStep) {
    final assetId = buildStep.inputId;
    print(assetId.path);
  }
}
