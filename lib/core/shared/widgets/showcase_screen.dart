import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_starter_app/app/di/injection.dart';
import 'package:flutter_starter_app/app/generated/app_localizations.dart';
import 'package:flutter_starter_app/app/language/language_cubit.dart';
import 'package:flutter_starter_app/app/language/language_state.dart';
import 'package:flutter_starter_app/app/theme/cubit/theme_cubit.dart';
import 'package:flutter_starter_app/app/theme/cubit/theme_state.dart';
import 'package:flutter_starter_app/core/network/connection_checker/internet_connection_cubit.dart';
import 'package:flutter_starter_app/core/network/connection_checker/internet_connection_state.dart';
import 'package:flutter_starter_app/core/network/rest_api_client.dart';
import 'package:flutter_starter_app/core/shared/extensions/app_localization.dart';
import 'package:flutter_starter_app/core/storage/drift/app_database.dart';
import 'package:flutter_starter_app/core/storage/simple_storage.dart';
import 'package:flutter_starter_app/core/utils/snackbar_util.dart';

class ShowcaseScreen extends StatefulWidget {
  const ShowcaseScreen({super.key});

  @override
  State<ShowcaseScreen> createState() => _ShowcaseScreenState();
}

class _ShowcaseScreenState extends State<ShowcaseScreen> {
  String? _networkResult;
  String? _storageValue;
  List<ExampleItem>? _dbItems;

  Future<void> _callNetwork() async {
    setState(() => _networkResult = context.localeKeys.loading);
    try {
      final response = await serviceLocator<RestApiClient>().getSomeData();
      setState(() => _networkResult = response.toString());
    } on DioException catch (e) {
      setState(() => _networkResult = context.localeKeys.error(e.message!));
    }
  }

  Future<void> _saveToStorage() async {
    final storage = serviceLocator<SimpleStorageService>();
    await storage.setString(
      'showcase_key',
      'Hello from Showcase! ${DateTime.now()}',
    );
  }

  Future<void> _readFromStorage() async {
    final storage = serviceLocator<SimpleStorageService>();
    final value = await storage.getString('showcase_key');
    setState(() {
      _storageValue = value ?? context.localeKeys.noValueFound;
    });
  }

  // Add item to Drift database
  Future<void> _addDbItem() async {
    final name = 'Item ${DateTime.now().millisecondsSinceEpoch}';
    final value = Random().nextInt(100);
    await serviceLocator<AppDatabase>().exampleItemsDao.insertItem(
      ExampleItemsCompanion(name: Value(name), value: Value(value)),
    );
    await _loadDbItems();
  }

  // Load all items from Drift database
  Future<void> _loadDbItems() async {
    final items = await serviceLocator<AppDatabase>().exampleItemsDao
        .getAllItems();
    if (mounted) {
      setState(() {
        _dbItems = items;
      });
    }
  }

  // Clear all items from Drift database
  Future<void> _clearDbItems() async {
    await serviceLocator<AppDatabase>().exampleItemsDao.clearAll();
    await _loadDbItems();
  }

  @override
  void initState() {
    unawaited(_loadDbItems());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final languageCubit = context.read<LanguageCubit>();

    return Scaffold(
      appBar: AppBar(title: Text(context.localeKeys.helloWorld)),
      body: ListView(
        padding: EdgeInsets.all(20.w), // <-- Use ScreenUtil for padding
        children: [
          _SectionCard(
            title: context.localeKeys.connectionStatus,
            child:
                BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        Text(
                          state.status.name,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        SizedBox(width: 8.w),
                        const Text(' - '),
                        SizedBox(width: 8.w),
                        Text(
                          state.connectionType.name,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ],
                    );
                  },
                ),
          ),
          SizedBox(height: 16.h),
          _SectionCard(
            title: context.localeKeys.theme,
            child: BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return Row(
                  children: [
                    Text(
                      context.localeKeys.current(state.themeMode.name),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    SizedBox(width: 16.w),
                    ElevatedButton.icon(
                      icon: Icon(Icons.brightness_6, size: 20.sp),
                      label: Text(
                        context.localeKeys.toggleTheme,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      onPressed: () async {
                        final isDark = state.themeMode == ThemeMode.dark;
                        await themeCubit.switchTheme(
                          isDark ? ThemeMode.light : ThemeMode.dark,
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 16.h),
          _SectionCard(
            title: context.localeKeys.language,
            child: BlocBuilder<LanguageCubit, LanguageState>(
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
            ),
          ),
          SizedBox(height: 16.h),
          _SectionCard(
            title: context.localeKeys.networking,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.cloud_download, size: 20.sp),
                  label: Text(
                    context.localeKeys.callNetwork,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  onPressed: _callNetwork,
                ),
                if (_networkResult != null) ...[
                  SizedBox(height: 8.h),
                  Text(_networkResult!, style: TextStyle(fontSize: 14.sp)),
                ],
              ],
            ),
          ),
          SizedBox(height: 16.h),
          _SectionCard(
            title: context.localeKeys.storage,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _saveToStorage,
                      child: Text(
                        context.localeKeys.saveValue,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    ElevatedButton(
                      onPressed: _readFromStorage,
                      child: Text(
                        context.localeKeys.readValue,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
                if (_storageValue != null) ...[
                  SizedBox(height: 8.h),
                  Text(
                    context.localeKeys.stored(_storageValue!),
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 16.h),
          _SectionCard(
            title: context.localeKeys.snackbarUtils,
            child: ElevatedButton.icon(
              icon: Icon(Icons.message, size: 20.sp),
              label: Text(
                context.localeKeys.showSnackbar,
                style: TextStyle(fontSize: 14.sp),
              ),
              onPressed: () {
                SnackbarUtil.showSnackbar(
                  context: context,
                  message: context.localeKeys.snackbarMessage,
                );
              },
            ),
          ),
          SizedBox(height: 16.h),
          _SectionCard(
            title: 'Drift Database',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _addDbItem,
                      child: Text(
                        'Add Item',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    ElevatedButton(
                      onPressed: _clearDbItems,
                      child: Text(
                        'Clear All',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                if (_dbItems == null)
                  SizedBox(
                    height: 24.h,
                    width: 24.h,
                    child: const CircularProgressIndicator(),
                  )
                else if (_dbItems!.isEmpty)
                  Text(
                    'No items in database.',
                    style: TextStyle(fontSize: 14.sp),
                  )
                else
                  ..._dbItems!.map(
                    (item) => Text(
                      'ID: ${item.id}, Name: ${item.name}, Value: ${item.value}',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: 8.h),
            child,
          ],
        ),
      ),
    );
  }
}
