import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:sineyorum/core/constants/app_constants.dart';
import 'package:sineyorum/core/themes/app_theme.dart';

class YoutubePlayerWidget extends StatefulWidget {
  final String videoId;
  final bool autoPlay;
  final bool showControls;
  final double aspectRatio;
  final Function(bool)? onPlayingStateChange;

  const YoutubePlayerWidget({
    super.key,
    required this.videoId,
    this.autoPlay = false,
    this.showControls = true,
    this.aspectRatio = 16 / 9,
    this.onPlayingStateChange,
  });

  @override
  State<YoutubePlayerWidget> createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    
    // Extract video ID from URL if full URL is provided
    String videoId = widget.videoId;
    if (videoId.contains('youtube.com') || videoId.contains('youtu.be')) {
      videoId = YoutubePlayer.convertUrlToId(videoId) ?? videoId;
    }
    
    // Extract Shorts ID
    if (videoId.contains('shorts/')) {
      final shortsMatch = RegExp(r'shorts/([a-zA-Z0-9_-]+)').firstMatch(videoId);
      if (shortsMatch != null) {
        videoId = shortsMatch.group(1)!;
      }
    }
    
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: widget.autoPlay,
        mute: false,
        enableCaption: true,
        captionLanguage: 'tr',
        isLive: false,
        forceHD: false,
        loop: false,
        controlsVisibleAtStart: widget.showControls,
        useHybridComposition: true,
        disableDragSeek: false,
      ),
    )..addListener(listener);
    
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
        
        // Notify parent about playing state
        if (_playerState == PlayerState.playing) {
          widget.onPlayingStateChange?.call(true);
        } else if (_playerState == PlayerState.paused ||
                   _playerState == PlayerState.ended) {
          widget.onPlayingStateChange?.call(false);
        }
      });
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: AppConstants.primaryColor,
            progressColors: ProgressBarColors(
              playedColor: AppConstants.primaryColor,
              handleColor: AppConstants.primaryColor,
              backgroundColor: AppConstants.surfaceColor,
              bufferedColor: AppConstants.textSecondaryColor,
            ),
            onReady: () {
              _isPlayerReady = true;
            },
            onEnded: (data) {
              _controller.load(data.videoId);
            },
          ),
          builder: (context, player) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: player,
              ),
            );
          },
        ),
        
        const SizedBox(height: 12),
        
        // Video Info
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Video Title
              if (_videoMetaData.title.isNotEmpty)
                Text(
                  _videoMetaData.title,
                  style: AppTheme.movieTitleStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              
              const SizedBox(height: 4),
              
              // Channel Info
              if (_videoMetaData.author.isNotEmpty)
                Row(
                  children: [
                    Text(
                      _videoMetaData.author,
                      style: AppTheme.movieOverviewStyle.copyWith(
                        fontSize: 12,
                        color: AppConstants.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppConstants.surfaceColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'YouTube',
                        style: AppTheme.movieOverviewStyle.copyWith(
                          fontSize: 10,
                          color: AppConstants.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Custom Controls
        if (widget.showControls)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Play/Pause
                IconButton(
                  icon: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    color: AppConstants.primaryColor,
                    size: 28,
                  ),
                  onPressed: _isPlayerReady
                      ? () {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        }
                      : null,
                ),
                
                // Mute/Unmute
                IconButton(
                  icon: Icon(
                    _muted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                    color: AppConstants.primaryColor,
                    size: 24,
                  ),
                  onPressed: _isPlayerReady
                      ? () {
                          _muted
                              ? _controller.unMute()
                              : _controller.mute();
                          setState(() {
                            _muted = !_muted;
                          });
                        }
                      : null,
                ),
                
                // Fullscreen
                IconButton(
                  icon: const Icon(
                    Icons.fullscreen_rounded,
                    color: AppConstants.primaryColor,
                    size: 24,
                  ),
                  onPressed: _isPlayerReady
                      ? () => _controller.toggleFullScreenMode()
                      : null,
                ),
                
                // Share
                IconButton(
                  icon: const Icon(
                    Icons.share_rounded,
                    color: AppConstants.primaryColor,
                    size: 24,
                  ),
                  onPressed: _isPlayerReady
                      ? () {
                          // Share video URL
                          final url = 'https://youtube.com/watch?v=${_controller.metadata.videoId}';
                          // Implement share functionality
                        }
                      : null,
                ),
              ],
            ),
          ),
        
        // Volume Slider
        if (widget.showControls)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Icon(
                  Icons.volume_down_rounded,
                  color: AppConstants.textSecondaryColor,
                  size: 20,
                ),
                Expanded(
                  child: Slider(
                    value: _volume,
                    min: 0,
                    max: 100,
                    divisions: 10,
                    label: '${_volume.round()}',
                    activeColor: AppConstants.primaryColor,
                    inactiveColor: AppConstants.surfaceColor,
                    onChanged: _isPlayerReady
                        ? (value) {
                            setState(() {
                              _volume = value;
                            });
                            _controller.setVolume(value.round());
                          }
                        : null,
                  ),
                ),
                const Icon(
                  Icons.volume_up_rounded,
                  color: AppConstants.textSecondaryColor,
                  size: 20,
                ),
              ],
            ),
          ),
        
        // Player State Info
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Current Time
              Text(
                _controller.value.position.inMinutes.remainder(60).toString().padLeft(2, '0') +
                ':' +
                _controller.value.position.inSeconds.remainder(60).toString().padLeft(2, '0'),
                style: AppTheme.movieOverviewStyle.copyWith(
                  fontSize: 12,
                  color: AppConstants.textSecondaryColor,
                ),
              ),
              
              // Player State
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getPlayerStateColor(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getPlayerStateText(),
                  style: AppTheme.movieOverviewStyle.copyWith(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              
              // Total Time
              Text(
                _controller.metadata.duration.inMinutes.remainder(60).toString().padLeft(2, '0') +
                ':' +
                _controller.metadata.duration.inSeconds.remainder(60).toString().padLeft(2, '0'),
                style: AppTheme.movieOverviewStyle.copyWith(
                  fontSize: 12,
                  color: AppConstants.textSecondaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getPlayerStateColor() {
    switch (_playerState) {
      case PlayerState.playing:
        return AppConstants.successColor;
      case PlayerState.paused:
        return AppConstants.warningColor;
      case PlayerState.ended:
        return AppConstants.errorColor;
      case PlayerState.buffering:
        return AppConstants.infoColor;
      default:
        return AppConstants.textSecondaryColor;
    }
  }

  String _getPlayerStateText() {
    switch (_playerState) {
      case PlayerState.playing:
        return 'ÇALIYOR';
      case PlayerState.paused:
        return 'DURAKLATILDI';
      case PlayerState.ended:
        return 'BİTTİ';
      case PlayerState.buffering:
        return 'YÜKLENİYOR';
      case PlayerState.unknown:
        return 'HAZIRLANIYOR';
      case PlayerState.unStarted:
        return 'BAŞLATILMADI';
      default:
        return 'BİLİNMİYOR';
    }
  }
}

// YouTube Shorts specific player (vertical format)
class YoutubeShortsPlayer extends StatelessWidget {
  final String shortsId;
  final bool autoPlay;

  const YoutubeShortsPlayer({
    super.key,
    required this.shortsId,
    this.autoPlay = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.black,
      ),
      child: YoutubePlayer(
        controller: YoutubePlayerController(
          initialVideoId: shortsId,
          flags: YoutubePlayerFlags(
            autoPlay: autoPlay,
            mute: false,
            enableCaption: false,
            isLive: false,
            forceHD: true,
            loop: true,
            controlsVisibleAtStart: true,
            useHybridComposition: true,
            disableDragSeek: false,
            showLiveFullscreenButton: false,
          ),
        ),
        aspectRatio: 9 / 16, // Vertical aspect ratio for Shorts
        showVideoProgressIndicator: true,
        progressIndicatorColor: AppConstants.primaryColor,
        progressColors: ProgressBarColors(
          playedColor: AppConstants.primaryColor,
          handleColor: AppConstants.primaryColor,
        ),
        onReady: () {
          debugPrint('Shorts Player is ready');
        },
        onEnded: (data) {
          debugPrint('Shorts ended: ${data.videoId}');
        },
      ),
    );
  }
}

// YouTube URL parser utility
class YoutubeUtils {
  static String? extractVideoId(String url) {
    try {
      return YoutubePlayer.convertUrlToId(url);
    } catch (e) {
      debugPrint('Error extracting video ID: $e');
      return null;
    }
  }

  static String? extractShortsId(String url) {
    try {
      final shortsMatch = RegExp(r'shorts/([a-zA-Z0-9_-]+)').firstMatch(url);
      if (shortsMatch != null) {
        return shortsMatch.group(1);
      }
      
      // Also check for youtu.be/shorts format
      final shortUrlMatch = RegExp(r'youtu\.be/([a-zA-Z0-9_-]+)').firstMatch(url);
      if (shortUrlMatch != null) {
        final id = shortUrlMatch.group(1);
        if (id != null && id.length == 11) {
          return id;
        }
      }
      
      return null;
    } catch (e) {
      debugPrint('Error extracting shorts ID: $e');
      return null;
    }
  }

  static bool isShortsUrl(String url) {
    return url.contains('shorts/') || 
           (url.contains('youtu.be') && !url.contains('watch'));
  }

  static String getWatchUrl(String videoId) {
    return 'https://youtube.com/watch?v=$videoId';
  }

  static String getShortsUrl(String shortsId) {
    return 'https://youtube.com/shorts/$shortsId';
  }

  static String getEmbedUrl(String videoId) {
    return 'https://www.youtube.com/embed/$videoId';
  }
}