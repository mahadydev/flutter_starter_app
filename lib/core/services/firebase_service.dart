import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_starter_app/app/di/injection.dart';
import 'package:flutter_starter_app/core/constants/storage_keys.dart';
import 'package:flutter_starter_app/core/storage/secure_storage.dart';
import 'package:flutter_starter_app/core/utils/logger_util.dart';
import 'package:flutter_starter_app/core/utils/snackbar_util.dart';

class FirebaseService {
  FirebaseService._();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<FirebaseService> create() async {
    final service = FirebaseService._();
    await service.init();
    return service;
  }

  Future<void> init() async {
    await _initializeAnalytics();
    await _initializeCrashlytics();
    await _initializeMessaging();
  }

  /// Initialize Firebase Analytics
  Future<void> _initializeAnalytics() async {
    // Log app open event
    await _analytics.logAppOpen();
    LoggerUtil.info('Firebase Analytics initialized');
  }

  /// Initialize Firebase Crashlytics
  Future<void> _initializeCrashlytics() async {
    if (kDebugMode) {
      await _crashlytics.setCrashlyticsCollectionEnabled(true);
    }
    LoggerUtil.info('Crashlytics initialized');
  }

  /// Initialize Firebase Cloud Messaging (FCM)
  Future<void> _initializeMessaging() async {
    // Request notification permissions
    await _messaging.requestPermission();

    String? fcmToken;

    // iOS/macOS: Check APNS token before getting FCM token
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      final apnsToken = await _messaging.getAPNSToken();
      if (apnsToken != null) {
        LoggerUtil.info('APNS Token: $apnsToken');
        fcmToken = await _messaging.getToken();
      } else {
        LoggerUtil.warning(
          'APNS token has not been set yet. FCM token will not be requested until APNS is available.',
        );
      }
    } else {
      // Android and other platforms: get FCM token directly
      fcmToken = await _messaging.getToken();
    }

    if (fcmToken != null) {
      LoggerUtil.info('FCM Token: $fcmToken');
      // Store the token securely
      final secureStorage = serviceLocator<SecureStorageService>();
      await secureStorage.setString(StorageKeys.fcmToken, fcmToken);
    }

    // Listen for token refresh
    _messaging.onTokenRefresh.listen((newToken) async {
      LoggerUtil.info('FCM Token refreshed: $newToken');
      final secureStorage = serviceLocator<SecureStorageService>();
      await secureStorage.setString(StorageKeys.fcmToken, newToken);
      // Optionally send the new token to your backend here
    });

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        LoggerUtil.info('Notification Title: ${message.notification?.title}');
        LoggerUtil.info('Notification Body: ${message.notification?.body}');
        SnackbarUtil.showSnackbar(
          message:
              'New notification received: ${message.notification?.body ?? ''}',
        );
      }
      if (message.data.isNotEmpty) {
        LoggerUtil.info('Custom FCM Data: ${message.data}');
      }
    });

    // Handle messages when the app is opened from a terminated state
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      LoggerUtil.info(
        'App opened from terminated state: ${initialMessage.notification?.title}',
      );
    }

    LoggerUtil.info('Firebase Messaging initialized');
  }

  /// Background message handler for FCM
  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    LoggerUtil.info(
      'Background message received: ${message.notification?.title}',
    );
  }
}
