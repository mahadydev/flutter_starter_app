import 'package:flutter/material.dart';
import 'package:flutter_starter_app/app/generated/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get localeKeys => AppLocalizations.of(this)!;
}
