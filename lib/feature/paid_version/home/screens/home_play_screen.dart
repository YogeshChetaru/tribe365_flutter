import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'link_click_screen.dart';

class PlayScreen extends StatefulWidget {
  final String title;
  final String subTitle;
  final String description;
  final String videoURL;

  const PlayScreen({
    super.key,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.videoURL,
  });

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  late YoutubePlayerController _controller;
  bool showDescription = false;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.videoURL) ?? "";
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        controlsVisibleAtStart: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void navigateBackToLinkClick() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => LinkClickScreen(
          titleName: widget.title,
          subTitleName: widget.subTitle,
          description: widget.description,
          videoURL: widget.videoURL,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850], // dark_grey
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(flex: 1, child: SizedBox()),

            Card(
              color: Colors.grey[850],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.all(16),
              elevation: 0,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: navigateBackToLinkClick,
                            ),
                            Expanded(
                              child: Text(
                                widget.title.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 40), // Placeholder for close icon
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            widget.subTitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: Colors.grey),

                  // Description or Video
                  showDescription
                      ? Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Text(
                          widget.description,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              showDescription = false;
                            });
                            _controller.play();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            minimumSize: const Size(80, 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text("Watch Video"),
                        ),
                      ],
                    ),
                  )
                      : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.red,
                    ),
                  ),
                ],
              ),
            ),

            const Expanded(flex: 1, child: SizedBox()),
          ],
        ),
      ),

      floatingActionButton: widget.description.isNotEmpty
          ? FloatingActionButton(
        onPressed: () {
          setState(() {
            showDescription = !showDescription;
            if (showDescription) {
              _controller.pause();
            }
          });
        },
        backgroundColor: Colors.red,
        child: Icon(showDescription ? Icons.play_arrow : Icons.info_outline),
      )
          : null,
    );
  }
}
