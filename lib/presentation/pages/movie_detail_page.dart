import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sineyorum/core/constants/app_constants.dart';
import 'package:sineyorum/core/themes/app_theme.dart';
import 'package:sineyorum/presentation/providers/ads_provider.dart';
import 'package:sineyorum/presentation/widgets/youtube_player_widget.dart';

class MovieDetailPage extends StatefulWidget {
  final String movieId;
  final String movieTitle;
  final String? youtubeVideoId;
  final bool isShorts;

  const MovieDetailPage({
    super.key,
    required this.movieId,
    required this.movieTitle,
    this.youtubeVideoId,
    this.isShorts = false,
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  bool _showInterstitialAd = false;

  @override
  void initState() {
    super.initState();
    
    // Show interstitial ad when entering movie details
    _showInterstitialAdOnEntry();
  }

  Future<void> _showInterstitialAdOnEntry() async {
    // Wait a bit for page to load
    await Future.delayed(const Duration(milliseconds: 500));
    
    final adsProvider = Provider.of<AdsProvider>(context, listen: false);
    
    // Show ad with 30% probability
    if (adsProvider.shouldShowAd(probability: 0.3)) {
      await adsProvider.showInterstitialAd();
      setState(() {
        _showInterstitialAd = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final adsProvider = Provider.of<AdsProvider>(context);
    
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: Text(
          widget.movieTitle,
          style: AppTheme.movieTitleStyle.copyWith(
            fontSize: 18,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_rounded),
            onPressed: () {
              // Share movie
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border_rounded),
            onPressed: () {
              // Add to watchlist
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // YouTube Player Section
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // YouTube Player
                    if (widget.youtubeVideoId != null)
                      Column(
                        children: [
                          if (widget.isShorts)
                            YoutubeShortsPlayer(
                              shortsId: widget.youtubeVideoId!,
                              autoPlay: true,
                            )
                          else
                            YoutubePlayerWidget(
                              videoId: widget.youtubeVideoId!,
                              autoPlay: false,
                              showControls: true,
                            ),
                          
                          const SizedBox(height: 20),
                          
                          // Video Info Card
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppConstants.surfaceColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.info_outline_rounded,
                                      color: AppConstants.primaryColor,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Video Bilgisi',
                                      style: AppTheme.movieTitleStyle.copyWith(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  widget.isShorts
                                      ? 'Bu bir YouTube Shorts videosudur. Kısa film fragmanı veya ilgili içerik olabilir.'
                                      : 'Film fragmanı veya ilgili video içeriği.',
                                  style: AppTheme.movieOverviewStyle,
                                ),
                                const SizedBox(height: 8),
                                if (widget.isShorts)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppConstants.primaryColor
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: AppConstants.primaryColor,
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.short_text_rounded,
                                          color: AppConstants.primaryColor,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'YouTube Shorts',
                                          style: AppTheme.movieOverviewStyle
                                              .copyWith(
                                            color: AppConstants.primaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      )
                    else
                      // Placeholder if no video
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppConstants.surfaceColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.videocam_off_rounded,
                              size: 48,
                              color: AppConstants.textSecondaryColor,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Video bulunamadı',
                              style: AppTheme.movieOverviewStyle,
                            ),
                          ],
                        ),
                      ),
                    
                    const SizedBox(height: 24),
                    
                    // Movie Details Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppConstants.surfaceColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.movieTitle,
                            style: AppTheme.movieTitleStyle.copyWith(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: AppConstants.primaryColor,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '8.5/10',
                                style: AppTheme.ratingStyle,
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppConstants.primaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'IMDb',
                                  style: AppTheme.premiumBadgeStyle.copyWith(
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
                            style: AppTheme.movieOverviewStyle,
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              'Aksiyon',
                              'Drama',
                              'Gerilim',
                              '2024',
                              '2s 15dk',
                            ].map((genre) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppConstants.backgroundColor,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppConstants.textSecondaryColor
                                        .withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  genre,
                                  style: AppTheme.movieOverviewStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Reviews Section
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppConstants.surfaceColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Yorumlar',
                                style: AppTheme.movieTitleStyle.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Navigate to all reviews
                                },
                                child: Text(
                                  'Tümünü Gör',
                                  style: AppTheme.movieOverviewStyle.copyWith(
                                    color: AppConstants.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          
                          // Sample Review
                          _buildReviewCard(
                            userName: 'Ahmet Yılmaz',
                            rating: 9.0,
                            review: 'Harika bir film! Özellikle son sahne beni çok etkiledi.',
                            date: '2 gün önce',
                            hasSpoiler: true,
                            likes: 24,
                          ),
                          
                          const SizedBox(height: 12),
                          
                          _buildReviewCard(
                            userName: 'Zeynep Kaya',
                            rating: 7.5,
                            review: 'İyi bir filmdi ama beklediğim kadar etkileyici değildi.',
                            date: '1 hafta önce',
                            hasSpoiler: false,
                            likes: 12,
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Add Review Button
                          ElevatedButton(
                            onPressed: () {
                              // Add review
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppConstants.primaryColor,
                              foregroundColor: Colors.black,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.edit_rounded),
                                SizedBox(width: 8),
                                Text('Yorum Yap'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Ad Banner (if not premium)
                    if (!adsProvider.isPremium && adsProvider.adsEnabled)
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppConstants.surfaceColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppConstants.textSecondaryColor
                                    .withOpacity(0.2),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.ads_click_rounded,
                                      color: AppConstants.textSecondaryColor,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Reklam',
                                      style: AppTheme.movieOverviewStyle
                                          .copyWith(
                                        fontSize: 12,
                                        color: AppConstants.textSecondaryColor,
                                      ),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        // Show premium dialog
                                      },
                                      child: Text(
                                        'Reklamsız İzle',
                                        style: AppTheme.movieOverviewStyle
                                            .copyWith(
                                          fontSize: 12,
                                          color: AppConstants.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                adsProvider.getBannerAdWidget(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Reklamlar uygulamanın geliştirilmesine yardımcı olur',
                            style: AppTheme.movieOverviewStyle.copyWith(
                              fontSize: 10,
                              color: AppConstants.textSecondaryColor
                                  .withOpacity(0.5),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      
      // Bottom Navigation
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppConstants.surfaceColor,
          border: Border(
            top: BorderSide(
              color: AppConstants.textSecondaryColor.withOpacity(0.1),
            ),
          ),
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Add to Watchlist
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Add to watchlist
                  },
                  icon: const Icon(Icons.bookmark_add_outlined),
                  label: const Text('Listeye Ekle'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppConstants.primaryColor,
                    side: BorderSide(color: AppConstants.primaryColor),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              
              // Rate Movie
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Rate movie
                  },
                  icon: const Icon(Icons.star_outline_rounded),
                  label: const Text('Puan Ver'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.primaryColor,
                    foregroundColor: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewCard({
    required String userName,
    required double rating,
    required String review,
    required String date,
    required bool hasSpoiler,
    required int likes,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppConstants.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppConstants.textSecondaryColor.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // User Avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppConstants.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    userName[0],
                    style: AppTheme.movieTitleStyle.copyWith(
                      fontSize: 16,
                      color: AppConstants.primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: AppTheme.movieTitleStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: AppConstants.primaryColor,
                          size: 14,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          rating.toStringAsFixed(1),
                          style: AppTheme.ratingStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          date,
                          style: AppTheme.movieOverviewStyle.copyWith(
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (hasSpoiler)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppConstants.warningColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppConstants.warningColor,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        color: AppConstants.warningColor,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'SPOILER',
                        style: AppTheme.spoilerWarningStyle,
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review,
            style: AppTheme.reviewContentStyle,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.thumb_up_alt_outlined,
                  size: 18,
                ),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              Text(
                likes.toString(),
                style: AppTheme.movieOverviewStyle.copyWith(
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(
                  Icons.thumb_down_alt_outlined,
                  size: 18,
                ),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.more_vert_rounded,
                  size: 18,
                ),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}