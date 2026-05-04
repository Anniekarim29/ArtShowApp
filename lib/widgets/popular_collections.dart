import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PopularCollections extends StatelessWidget {
  final ScrollController scrollController;

  const PopularCollections({super.key, required this.scrollController});

  final List<Map<String, dynamic>> _collections = const [
    {
      'image': 'assets/download.jpeg',
      'title': 'Neon Genesis',
      'category': 'Cyberpunk',
      'artist': 'Kenji R.',
      'stats': '120 Artworks',
    },
    {
      'image': 'assets/monalisa.png',
      'title': 'Classic Reimagined',
      'category': 'Digital Paint',
      'artist': 'Elena V.',
      'stats': '45 Artworks',
    },
    {
      'image': 'assets/soul_diy.jpeg',
      'title': 'Soul Abstracts',
      'category': 'Abstract',
      'artist': 'Marcus T.',
      'stats': '89 Artworks',
    },
    {
      'image': 'assets/download_7.jpeg',
      'title': 'Minimalist Echo',
      'category': 'Minimalism',
      'artist': 'Sophia L.',
      'stats': '60 Artworks',
    },
    {
      'image': 'assets/The Five Stages Of Grief_ Exploring The Kübler-Ross Model.jpeg',
      'title': 'Emotional Spectrum',
      'category': 'Surrealism',
      'artist': 'David K.',
      'stats': '34 Artworks',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _collections.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: Container(
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  // Parallax Image Background
                  AnimatedBuilder(
                    animation: scrollController,
                    builder: (context, child) {
                      double offset = 0.0;
                      if (scrollController.hasClients) {
                        // Calculate offset based on scroll position
                        offset = scrollController.offset * 0.2;
                      }
                      return Positioned(
                        top: -50 + offset, // Basic parallax effect
                        bottom: -50 - offset,
                        left: 0,
                        right: 0,
                        child: child!,
                      );
                    },
                    child: Image.asset(
                      _collections[index]['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Theme.of(context).colorScheme.surface.withOpacity(0.9),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  // Content
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            _collections[index]['category'],
                            style: const TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _collections[index]['title'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _collections[index]['artist'],
                              style: const TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                            Text(
                              _collections[index]['stats'],
                              style: const TextStyle(color: Colors.white70, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: Duration(milliseconds: 600 + (index * 200))).slideX(begin: 0.2, end: 0),
        );
      },
    );
  }
}
