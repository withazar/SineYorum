class AppConstants {
  // App Info
  static const String appName = 'SineYorum';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';
  
  // API Keys (from .env)
  static String get tmdbApiKey => const String.fromEnvironment('TMDB_API_KEY');
  static String get youtubeApiKey => const String.fromEnvironment('YOUTUBE_API_KEY');
  
  // AdMob IDs (Test IDs for development)
  static const String admobAppId = 'ca-app-pub-3940256099942544~3347511713';
  static const String admobBannerId = 'ca-app-pub-3940256099942544/6300978111';
  static const String admobInterstitialId = 'ca-app-pub-3940256099942544/1033173712';
  static const String admobRewardedId = 'ca-app-pub-3940256099942544/5224354917';
  
  // TMDB API
  static const String tmdbBaseUrl = 'https://api.themoviedb.org/3';
  static const String tmdbImageBaseUrl = 'https://image.tmdb.org/t/p';
  
  // YouTube API
  static const String youtubeBaseUrl = 'https://www.googleapis.com/youtube/v3';
  
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String reviewsCollection = 'reviews';
  static const String watchlistCollection = 'watchlist';
  static const String reportsCollection = 'reports';
  
  // App URLs
  static const String privacyPolicyUrl = 'https://sineyorum.web.app/privacy';
  static const String termsOfServiceUrl = 'https://sineyorum.web.app/terms';
  static const String supportEmail = 'support@sineyorum.com';
  
  // App Store Links
  static const String playStoreUrl = 'https://play.google.com/store/apps/details?id=com.withazar.sineyorum';
  static const String appStoreUrl = 'https://apps.apple.com/app/sineyorum/id';
  
  // Social Media
  static const String twitterUrl = 'https://twitter.com/sineyorum';
  static const String instagramUrl = 'https://instagram.com/sineyorum';
  static const String telegramUrl = 'https://t.me/sineyorum';
  
  // Cache Duration
  static const Duration cacheDuration = Duration(minutes: 30);
  static const Duration splashDuration = Duration(seconds: 2);
  
  // Pagination
  static const int moviesPerPage = 20;
  static const int reviewsPerPage = 10;
  
  // Ratings
  static const double minRating = 1.0;
  static const double maxRating = 10.0;
  static const int ratingSteps = 10;
  
  // Premium Pricing
  static const double monthlyPrice = 1.99;
  static const double yearlyPrice = 19.99;
  static const double lifetimePrice = 49.99;
  
  // Local Storage Keys
  static const String themeKey = 'theme';
  static const String languageKey = 'language';
  static const String firstLaunchKey = 'first_launch';
  static const String userIdKey = 'user_id';
  static const String premiumKey = 'premium';
  
  // Error Messages
  static const String networkError = 'İnternet bağlantınızı kontrol edin';
  static const String serverError = 'Sunucu hatası oluştu';
  static const String unknownError = 'Bilinmeyen bir hata oluştu';
  static const String authError = 'Giriş yapmanız gerekiyor';
  static const String permissionError = 'Bu işlem için izniniz yok';
  
  // Success Messages
  static const String reviewAdded = 'Yorumunuz başarıyla eklendi';
  static const String reviewUpdated = 'Yorumunuz güncellendi';
  static const String reviewDeleted = 'Yorumunuz silindi';
  static const String movieAddedToWatchlist = 'Film izleme listesine eklendi';
  static const String movieRemovedFromWatchlist = 'Film izleme listesinden çıkarıldı';
  
  // Validation Messages
  static const String reviewRequired = 'Yorum alanı boş olamaz';
  static const String reviewMinLength = 'Yorum en az 10 karakter olmalı';
  static const String reviewMaxLength = 'Yorum en fazla 1000 karakter olabilir';
  static const String ratingRequired = 'Puan vermeniz gerekiyor';
  
  // App Colors (Dark Theme)
  static const Color primaryColor = Color(0xFFFFD700); // Popcorn Sarısı
  static const Color secondaryColor = Color(0xFFE50914); // Netflix Kırmızısı
  static const Color backgroundColor = Color(0xFF121212); // Koyu arkaplan
  static const Color surfaceColor = Color(0xFF1E1E1E); // Yüzey rengi
  static const Color textColor = Color(0xFFFFFFFF); // Beyaz yazı
  static const Color textSecondaryColor = Color(0xFFB3B3B3); // Gri yazı
  static const Color errorColor = Color(0xFFCF6679); // Hata rengi
  static const Color successColor = Color(0xFF4CAF50); // Başarı rengi
  static const Color warningColor = Color(0xFFFF9800); // Uyarı rengi
  static const Color infoColor = Color(0xFF2196F3); // Bilgi rengi
}