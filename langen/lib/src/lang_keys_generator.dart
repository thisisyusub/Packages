import 'dart:async';
import 'dart:collection';
import 'dart:convert' show json;
import 'dart:io';

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
        '.json': ['lang_keys.dart']
      };

  /// stores all keys of json files
  final List<String> _allKeys = <String>[];

  /// do some logic
  final output = 'lib/utils/constants/language_keys.dart';

  /// to perform fast String concatenation
  final sb = StringBuffer();

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final assetId = buildStep.inputId;

    if (assetId.pathSegments.contains('langs')) {
      /// gets [lang code] of current json file
      // final langCode = assetId.pathSegments.last.split('.').first;

      /// reads current [*.json] file
      final file = await buildStep.readAsString(assetId);

      /// converts json string to Map
      Map<String, dynamic> keysAndValues = json.decode(file);

      /// collects all keys of current language
      final currentLangKeys = HashSet<String>();

      /// collects all values of current language
      for (var keyAndValue in keysAndValues.entries) {
        /// if already has this key it will omit
        /// this key for current json file
        if (_allKeys.contains(keyAndValue.key)) continue;

        _allKeys.add(keyAndValue.key);
        currentLangKeys.add(keyAndValue.key);
      }

      for (var i = 0; i < currentLangKeys.length; i++) {
        final currentKey = currentLangKeys.elementAt(i);
        sb.writeln(' const String ${currentKey.capitalize} = \'$currentKey\';');
        sb.writeln();
      }

      /// write all data to [language_keys.dart] file in [utils/constants] directory
      var writingFile = File(output);
      var writer = writingFile.openWrite();
      writer.write(sb.toString());
      await writer.close();
    }
  }
}
