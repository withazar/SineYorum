import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sineyorum/core/constants/app_constants.dart';
import 'package:sineyorum/core/themes/app_theme.dart';
import 'package:sineyorum/presentation/providers/ads_provider.dart';
import 'package:sineyorum/presentation/providers/auth_provider.dart';
import 'package:sineyorum/presentation/pages/home_page.dart';
import 'package:sineyorum/presentation/pages/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animation
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    
    // Start animation
    _controller.forward();
    
    // Initialize app and navigate
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Initialize providers
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final adsProvider = Provider.of<AdsProvider>(context, listen: false);
      
      // Check authentication status
      await authProvider.checkAuthStatus();
      
      // Initialize ads (if not premium)
      if (!authProvider.currentUser?.isPremium ?? true) {
        await adsProvider.initializeAds(context);
      }
      
      // Wait for splash duration
      await Future.delayed(AppConstants.splashDuration);
      
      // Navigate to appropriate page
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => authProvider.isAuthenticated
                ? const HomePage()
                : const LoginPage(),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error during app initialization: $e');
      
      // Navigate to home page even if there's an error
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo/Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppConstants.primaryColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: AppConstants.primaryColor.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.movie_creation_outlined,
                  size: 60,
                  color: Colors.black,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // App Name with Animation
              ScaleTransition(
                scale: _animation,
                child: Text(
                  AppConstants.appName,
                  style: AppTheme.movieTitleStyle.copyWith(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: AppConstants.primaryColor,
                  ),
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Tagline
              FadeTransition(
                opacity: _animation,
                child: Text(
                  'Film Yorumlama Platformu',
                  style: AppTheme.movieOverviewStyle.copyWith(
                    fontSize: 16,
                    color: AppConstants.textSecondaryColor,
                  ),
                ),
              ),
              
              const SizedBox(height: 48),
              
              // Loading Indicator
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppConstants.primaryColor,
                  ),
                  strokeWidth: 3,
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Loading Text
              FadeTransition(
                opacity: _animation,
                child: Text(
                  'Yükleniyor...',
                  style: AppTheme.movieOverviewStyle.copyWith(
                    fontSize: 14,
                    color: AppConstants.textSecondaryColor,
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Version Info
              Positioned(
                bottom: 32,
                child: FadeTransition(
                  opacity: _animation,
                  child: Text(
                    'v${AppConstants.appVersion}',
                    style: AppTheme.movieOverviewStyle.copyWith(
                      fontSize: 12,
                      color: AppConstants.textSecondaryColor.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}