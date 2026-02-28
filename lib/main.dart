import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:sineyorum/core/constants/app_constants.dart';
import 'package:sineyorum/core/themes/app_theme.dart';
import 'package:sineyorum/presentation/providers/theme_provider.dart';
import 'package:sineyorum/presentation/providers/auth_provider.dart';
import 'package:sineyorum/presentation/providers/movie_provider.dart';
import 'package:sineyorum/presentation/providers/ads_provider.dart';
import 'package:sineyorum/presentation/pages/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables
  await dotenv.load(fileName: '.env');
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  // Initialize AdMob
  await MobileAds.instance.initialize();
  RequestConfiguration requestConfiguration = RequestConfiguration(
    testDeviceIds: ['TEST_DEVICE_ID'], // Test cihaz ID'si
  );
  MobileAds.instance.updateRequestConfiguration(requestConfiguration);
  
  runApp(const SineYorumApp());
}

class SineYorumApp extends StatelessWidget {
  const SineYorumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MovieProvider()),
        ChangeNotifierProvider(create: (_) => AdsProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            locale: const Locale('tr', 'TR'),
            supportedLocales: const [
              Locale('tr', 'TR'),
              Locale('en', 'US'),
            ],
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}