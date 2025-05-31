import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_app/app/di/injection.dart';
import 'package:flutter_starter_app/app/generated/app_localizations.dart';
import 'package:flutter_starter_app/app/language/language_cubit.dart';
import 'package:flutter_starter_app/app/language/language_state.dart';
import 'package:flutter_starter_app/app/router/app_router.dart';
import 'package:flutter_starter_app/app/theme/app_theme.dart';
import 'package:flutter_starter_app/app/theme/cubit/theme_cubit.dart';
import 'package:flutter_starter_app/app/theme/cubit/theme_state.dart';
import 'package:flutter_starter_app/core/constants/app_constants.dart';
import 'package:flutter_starter_app/core/network/connection_checker/internet_connection_cubit.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<ThemeCubit>()),
        BlocProvider(create: (_) => serviceLocator<LanguageCubit>()),
        BlocProvider(create: (_) => serviceLocator<InternetConnectionCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, languageState) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                scaffoldMessengerKey: scaffoldMessengerKey,
                title: AppConstants.appName,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: languageState.locale,
                routerConfig: AppRouter.router,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeState.themeMode,
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context),
                    child: child!,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
