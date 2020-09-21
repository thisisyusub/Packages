import 'dart:async';
import 'dart:collection';
import 'dart:convert' show json;

import 'package:build/build.dart';

extension on String {
  String get capitalize {
    final splitParts = split('_');
    var res = splitParts[0];
    for (var i = 1; i < splitParts.length; i++) {
      res += splitParts[i][0].toUpperCase() + splitParts[i].substring(1);
    }
    return res;
  }
}

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
  FutureOr<void> build(BuildStep buildStep) async {
    final assetId = buildStep.inputId;

    if (assetId.pathSegments.contains('langs')) {
      /// gets [lang code] of current json file
      final langCode = assetId.pathSegments.last.split('.').first;

      /// reads current [*.json] file
      final file = await buildStep.readAsString(assetId);

      /// converts json string to Map
      Map<String, dynamic> keysAndValues = json.decode(file);

      /// adds [language key] to HashSet
      languageCodes.add(langCode);

      /// collects all keys of current language
      final currentLangKeys = HashSet<String>();

      final currentLangWithValues = <String, dynamic>{};

      /// collects all values of current langauge
      for (var keyAndValue in keysAndValues.entries) {
        valueKeys.add(keyAndValue.key);
        currentLangKeys.add(keyAndValue.key);
        currentLangWithValues.putIfAbsent(
            keyAndValue.key, () => keyAndValue.value);
      }

      languageKeysWithJsonKeys.putIfAbsent(langCode, () => currentLangKeys);
      languageKeysWithJsonValues.putIfAbsent(
          langCode, () => currentLangWithValues);

      /// to perform fast String concatenation
      final sb = StringBuffer();

      for (var i = 0; i < valueKeys.length; i++) {
        final currentKey = valueKeys.elementAt(i);

        for (var langCode in languageCodes) {
          final isCurrentLangFileContainsCurentKey =
              languageKeysWithJsonKeys[langCode].contains(currentKey);

          final message = isCurrentLangFileContainsCurentKey
              ? languageKeysWithJsonValues[langCode][currentKey]
              : '[Null]';

          sb.writeln(
            '  /// ${isCurrentLangFileContainsCurentKey ? '' : '!'}'
            ' ${langCode.toUpperCase()}: ${message.replaceAll('\n', ' ')}',
          );
        }
        sb.writeln(' const String ${currentKey.capitalize} = \'$currentKey\';');

        if (i != valueKeys.length - 1) {
          sb.writeln();
        }
      }

      final copyAssetId = assetId.changeExtension('.g.dart');
      await buildStep.writeAsString(copyAssetId, sb.toString());
    }
  }
}
