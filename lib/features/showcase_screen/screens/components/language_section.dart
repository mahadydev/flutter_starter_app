import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_starter_app/app/generated/app_localizations.dart';
import 'package:flutter_starter_app/app/language/language_cubit.dart';
import 'package:flutter_starter_app/app/language/language_state.dart';
import 'package:flutter_starter_app/core/shared/extensions/app_localization.dart';

class LanguageSection extends StatelessWidget {
  const LanguageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final languageCubit = context.read<LanguageCubit>();

    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, langState) {
        return Row(
          children: [
            Text(
              context.localeKeys.current(
                langState.locale?.languageCode.toUpperCase() ?? '',
              ),
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: DropdownButton<Locale>(
                isExpanded: true,
                value: langState.locale,
                onChanged: (Locale? newLocale) async {
                  if (newLocale != null) {
                    await languageCubit.switchLanguage(newLocale);
                  }
                },
                items: AppLocalizations.supportedLocales.map((locale) {
                  return DropdownMenuItem<Locale>(
                    value: locale,
                    child: Text(
                      locale.toLanguageTag().toUpperCase(),
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
