import 'dart:async';
import 'dart:collection';

import 'package:build/build.dart';
import 'package:flutter/foundation.dart';

class LangKeysGenerator implements Builder {
  @override
  Map<String, List<String>> get buildExtensions => {
        '.json': ['lang_keys.dart'],
      };

  /// used to store keys of language keys for documentation
  /// will be used to control if the current file contains
  /// current json key or not
  final languageKeysWithJsonKeys = <String, HashSet<String>>{};

  /// used to store values of keys for documentation
  final languageKeysWithJsonValues = <String, Map<String, dynamic>>{};

  /// stores [all keys] used in app
  final valueKeys = HashSet<String>();

  /// stores all languageCodes used in app
  final languageCodes = HashSet<String>();

  @override
  FutureOr<void> build(BuildStep buildStep) {
    final assetId = buildStep.inputId;

    if (assetId.pathSegments.contains('langs')) {
      debugPrint(assetId.package);
      debugPrint(assetId.path);
      debugPrint('${assetId.pathSegments}');
    }
  }
}
