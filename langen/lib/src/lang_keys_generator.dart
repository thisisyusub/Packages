import 'dart:async';
import 'dart:collection';
import 'dart:convert' show json;

import 'package:build/build.dart';

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

  /// stores all languageCodes used in app
  final languageCodes = HashSet<String>();

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final assetId = buildStep.inputId;

    if (assetId.pathSegments.contains('langs')) {
      /// gets [lang code] of current json file
      final langCode = assetId.pathSegments.last.split('.').first;

      /// reads current [*.json] file
      final file = await buildStep.readAsString(assetId);

      /// converts json string to Map
      Map<String, dynamic> keyAndValues = json.decode(file);

      /// adds [language key] to HashSet
      languageCodes.add(langCode);

      print(languageCodes);
    }
  }
}
