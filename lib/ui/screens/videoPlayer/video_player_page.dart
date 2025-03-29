import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:kids_app/ui/components/video_player_widget.dart';
import 'package:kids_app/ui/screens/videoPlayer/exit_confirmation_page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';

class VideoPage extends StatefulWidget {
  final List<String> videoUrls;

  const VideoPage({Key? key, required this.videoUrls}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  int currentIndex = 0;
  bool isVideo = false;
  late YoutubePlayerController _youtubeController;
  late String host;

  @override
  void initState() {
    super.initState();
    _checkIfVideo(widget.videoUrls[currentIndex]);
  }

  Future<void> _checkIfVideo(String url) async {
    try {
      Uri uri = Uri.parse(url);
      host = uri.host;

      bool videoDetected = false;

      if (host.contains("youtube.com") || host.contains("youtu.be")) {
        videoDetected = true;
        _initializeYoutubePlayer(url);
      } else if (host.contains("vimeo.com")) {
        videoDetected = true;
      } else if (host.contains("dailymotion.com") || host.contains("dai.ly")) {
        videoDetected = true;
      } else {
        final response = await http.head(Uri.parse(url));
        final contentType = response.headers['content-type'];
        if (contentType != null && contentType.startsWith('video/')) {
          videoDetected = true;
        }
      }

      setState(() {
        isVideo = videoDetected;
      });
    } catch (e) {
      setState(() {
        isVideo = false;
      });
    }
  }

  void _initializeYoutubePlayer(String url) {
    String videoId = YoutubePlayer.convertUrlToId(url) ?? '';
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  void _navigateToNextVideo() {
    if (currentIndex < widget.videoUrls.length - 1) {
      setState(() {
        currentIndex++;
        _checkIfVideo(widget.videoUrls[currentIndex]);
      });
    }
  }

  void _navigateToPreviousVideo() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        _checkIfVideo(widget.videoUrls[currentIndex]);
      });
    }
  }

  @override
  void dispose() {
    if (isVideo && host.contains("youtube.com")) {
      _youtubeController.dispose();
    }

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ExitConfirmationPage(),
          ),
        );
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    SystemChrome.setPreferredOrientations(
                        [DeviceOrientation.portraitUp]);
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Text(
                    _youtubeController.metadata.title.isNotEmpty
                        ? _youtubeController.metadata.title
                        : "Loading...",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            Expanded(
              child: isVideo
                  ? host.contains("youtube.com") || host.contains("youtu.be")
                      ? YoutubePlayer(
                          controller: _youtubeController,
                          showVideoProgressIndicator: true,
                          onReady: () {
                            _youtubeController.toggleFullScreenMode();
                            SystemChrome.setPreferredOrientations([
                              DeviceOrientation.landscapeRight,
                              DeviceOrientation.landscapeLeft,
                            ]);
                          },
                          onEnded: (data) {
                            _navigateToNextVideo();
                          },
                        )
                      : VideoPlayerWidget(
                          videoUrl: widget.videoUrls[currentIndex],
                          onVideoEnd: _navigateToNextVideo,
                        )
                  : const Center(
                      child: Text(
                        "This URL does not contain a video.",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${currentIndex + 1} / ${widget.videoUrls.length}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
