# Langen

A simple package to generate language json keys to Dart Strings.

## Overview

Sometimes, we need to use `Localization` in our apps. But it is difficult and time wasted to look at and take `json key` in language json files. This package is developed to solve this problem. It will generate new `lang_keys.dart` file where all keys from all language json files are collected.

## Usage

First of all, make sure you have added the following dependencies:

```yaml
dev_dependencies:
  build_runner: ^1.9.0
  langen: ^0.0.3
```

> Run `flutter pub get` to get dependencies.

Then, you should add directory called `langs` to locate language jsons. `langen` will automatically search for this folder and handle generation.

> Make sure you have added language jsons - for example, `en.json`, `az.json`, etc to `langs` folder. And make sure that you have filled language jsons correctly.

`az.json`
```json
{
    "hi": "Salam",
    "bye": "Sağol"
}
```

`en.json`
```json
{
    "hi": "Hello",
    "bye": "Bye",
    "test": "test"
}
```

Then, you should add 2 nested directories to `lib` directory - `utils/constants/`. Because, `langen` generates keys to `constants` directory located in `lib/utils/constants`.

And last step, run the following command to generate your file:

`flutter pub run build_runner build`

If you want to enable generation for next steps (when you add new keys and values to language jsons), you can run the following command:

`flutter pub run build_runner watch`


