import 'package:flutter/material.dart';
import 'package:kids_app/ui/screens/videoPlayer/video_player_page.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String description;
  final String duration;
  final String imageUrl;

  const MovieCard({
    super.key,
    required this.title,
    required this.description,
    required this.duration,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.0,
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VideoPage(
                    videoUrls: [
                      'https://www.youtube.com/watch?v=IAkVzdUAR_w',
                      'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
                      'https://youtu.be/RFkkYVxyJYI?si=xqCwfyeoB_wwr6g9'
                    ],
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.network(
                      imageUrl,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 180,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          child: const Icon(Icons.error, color: Colors.red),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                duration,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MovieCardList extends StatelessWidget {
  final List<dynamic> movies;

  const MovieCardList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(movies.length, (index) {
            final movie = movies[index];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.1),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MovieCard(
                  title: movie['title']!,
                  description: movie['description']!,
                  duration: movie['duration']!,
                  imageUrl: movie['imageUrl']!,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
