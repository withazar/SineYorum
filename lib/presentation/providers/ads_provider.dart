import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:sineyorum/core/constants/app_constants.dart';
import 'package:sineyorum/presentation/providers/auth_provider.dart';

class AdsProvider with ChangeNotifier {
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  
  bool _adsEnabled = true;
  bool _isPremium = false;
  bool _isLoading = false;
  String? _error;
  
  // Getters
  BannerAd? get bannerAd => _bannerAd;
  InterstitialAd? get interstitialAd => _interstitialAd;
  RewardedAd? get rewardedAd => _rewardedAd;
  bool get adsEnabled => _adsEnabled;
  bool get isPremium => _isPremium;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  // Initialize ads
  Future<void> initializeAds(BuildContext context) async {
    if (_isPremium) {
      _adsEnabled = false;
      notifyListeners();
      return;
    }
    
    try {
      _isLoading = true;
      notifyListeners();
      
      // Check if user is premium
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      _isPremium = authProvider.currentUser?.isPremium ?? false;
      
      if (_isPremium) {
        _adsEnabled = false;
        _isLoading = false;
        notifyListeners();
        return;
      }
      
      // Load banner ad
      await _loadBannerAd();
      
      // Load interstitial ad (preload for later use)
      await _loadInterstitialAd();
      
      // Load rewarded ad (preload for later use)
      await _loadRewardedAd();
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
  
  // Load banner ad
  Future<void> _loadBannerAd() async {
    _bannerAd = BannerAd(
      adUnitId: AppConstants.admobBannerId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('Banner ad loaded successfully');
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Banner ad failed to load: $error');
          ad.dispose();
          _bannerAd = null;
          notifyListeners();
        },
        onAdOpened: (ad) => debugPrint('Banner ad opened'),
        onAdClosed: (ad) => debugPrint('Banner ad closed'),
        onAdImpression: (ad) => debugPrint('Banner ad impression recorded'),
      ),
    );
    
    await _bannerAd?.load();
    notifyListeners();
  }
  
  // Load interstitial ad
  Future<void> _loadInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: AppConstants.admobInterstitialId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          debugPrint('Interstitial ad loaded successfully');
          
          // Set full screen content callback
          _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {
              debugPrint('Interstitial ad showed full screen content');
            },
            onAdDismissedFullScreenContent: (ad) {
              debugPrint('Interstitial ad dismissed full screen content');
              ad.dispose();
              _loadInterstitialAd(); // Preload next ad
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              debugPrint('Interstitial ad failed to show: $error');
              ad.dispose();
              _loadInterstitialAd(); // Preload next ad
            },
            onAdImpression: (ad) {
              debugPrint('Interstitial ad impression recorded');
            },
          );
          
          notifyListeners();
        },
        onAdFailedToLoad: (error) {
          debugPrint('Interstitial ad failed to load: $error');
          _interstitialAd = null;
          notifyListeners();
        },
      ),
    );
  }
  
  // Load rewarded ad
  Future<void> _loadRewardedAd() async {
    await RewardedAd.load(
      adUnitId: AppConstants.admobRewardedId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          debugPrint('Rewarded ad loaded successfully');
          
          // Set full screen content callback
          _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {
              debugPrint('Rewarded ad showed full screen content');
            },
            onAdDismissedFullScreenContent: (ad) {
              debugPrint('Rewarded ad dismissed full screen content');
              ad.dispose();
              _loadRewardedAd(); // Preload next ad
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              debugPrint('Rewarded ad failed to show: $error');
              ad.dispose();
              _loadRewardedAd(); // Preload next ad
            },
            onAdImpression: (ad) {
              debugPrint('Rewarded ad impression recorded');
            },
          );
          
          notifyListeners();
        },
        onAdFailedToLoad: (error) {
          debugPrint('Rewarded ad failed to load: $error');
          _rewardedAd = null;
          notifyListeners();
        },
      ),
    );
  }
  
  // Show interstitial ad (e.g., when entering movie details)
  Future<void> showInterstitialAd() async {
    if (_isPremium || !_adsEnabled || _interstitialAd == null) {
      return;
    }
    
    try {
      await _interstitialAd?.show();
    } catch (e) {
      debugPrint('Failed to show interstitial ad: $e');
    }
  }
  
  // Show rewarded ad (e.g., for premium features)
  Future<void> showRewardedAd({
    required Function(RewardItem) onRewardEarned,
    Function()? onAdDismissed,
    Function()? onAdFailed,
  }) async {
    if (_isPremium || !_adsEnabled || _rewardedAd == null) {
      return;
    }
    
    try {
      _rewardedAd?.show(
        onUserEarnedReward: (ad, reward) {
          debugPrint('User earned reward: ${reward.amount} ${reward.type}');
          onRewardEarned(reward);
        },
      );
      
      // Set callbacks
      _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          onAdDismissed?.call();
          ad.dispose();
          _loadRewardedAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          onAdFailed?.call();
          ad.dispose();
          _loadRewardedAd();
        },
      );
    } catch (e) {
      debugPrint('Failed to show rewarded ad: $e');
      onAdFailed?.call();
    }
  }
  
  // Toggle ads (for testing or user preference)
  void toggleAds(bool enabled) {
    _adsEnabled = enabled;
    
    if (!enabled) {
      _disposeAds();
    } else {
      // Reinitialize ads if enabled
      // Note: Need context for reinitialization
    }
    
    notifyListeners();
  }
  
  // Set premium status
  void setPremium(bool isPremium) {
    _isPremium = isPremium;
    
    if (isPremium) {
      _adsEnabled = false;
      _disposeAds();
    } else {
      _adsEnabled = true;
      // Note: Need context for reinitialization
    }
    
    notifyListeners();
  }
  
  // Dispose ads
  void _disposeAds() {
    _bannerAd?.dispose();
    _bannerAd = null;
    
    _interstitialAd?.dispose();
    _interstitialAd = null;
    
    _rewardedAd?.dispose();
    _rewardedAd = null;
    
    notifyListeners();
  }
  
  // Get banner ad widget
  Widget getBannerAdWidget() {
    if (_isPremium || !_adsEnabled || _bannerAd == null) {
      return const SizedBox.shrink();
    }
    
    return Container(
      alignment: Alignment.center,
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }
  
  // Check if should show ad (with probability)
  bool shouldShowAd({double probability = 0.3}) {
    if (_isPremium || !_adsEnabled) {
      return false;
    }
    
    // Use probability to control ad frequency
    final random = DateTime.now().millisecond % 100;
    return random < (probability * 100);
  }
  
  // Reset provider
  void reset() {
    _disposeAds();
    _adsEnabled = true;
    _isPremium = false;
    _isLoading = false;
    _error = null;
    notifyListeners();
  }
  
  @override
  void dispose() {
    _disposeAds();
    super.dispose();
  }
}