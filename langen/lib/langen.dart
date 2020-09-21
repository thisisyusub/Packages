library langen;

import 'package:build/build.dart';

import './src/lang_keys_generator.dart';

/// convention used by [build] package for generation process
Builder langen(BuilderOptions options) => LangKeysGenerator();
