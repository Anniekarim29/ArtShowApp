import 'package:flutter/material.dart';
import 'dart:math';

class TrendingCarousel extends StatefulWidget {
  const TrendingCarousel({super.key});

  @override
  State<TrendingCarousel> createState() => _TrendingCarouselState();
}

class _TrendingCarouselState extends State<TrendingCarousel> {
  late PageController _pageController;
  int _currentPage = 1;

  final List<Map<String, dynamic>> _artworks = [
    {
      'image': 'assets/van_gogh.jpeg',
      'title': 'Starry Echo',
      'artist': 'Vincent V.',
      'views': '12k',
      'likes': '3.4k',
    },
    {
      'image': 'assets/soul_diy.jpeg',
      'title': 'Neon Soul',
      'artist': 'DIY Crafter',
      'views': '24k',
      'likes': '8.1k',
    },
    {
      'image': 'assets/download.jpeg',
      'title': 'Cyber Dream',
      'artist': 'Alex Neon',
      'views': '18k',
      'likes': '5.2k',
    },
    {
      'image': 'assets/download_6.jpeg',
      'title': 'Abstract Mind',
      'artist': 'Sarah J.',
      'views': '9k',
      'likes': '2.1k',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: 0.7,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      child: PageView.builder(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        itemCount: _artworks.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double value = 1.0;
              if (_pageController.position.haveDimensions) {
                value = _pageController.page! - index;
                value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
              } else {
                value = index == _currentPage ? 1.0 : 0.7;
              }
              
              // Apply rotation for 3D effect
              double angle = 0;
              if (_pageController.position.haveDimensions) {
                angle = (_pageController.page! - index) * 0.15; // Increased for better animation
              } else {
                angle = (index - _currentPage) * -0.15;
              }

              return Center(
                child: SizedBox(
                  height: Curves.easeOut.transform(value) * 420,
                  width: Curves.easeOut.transform(value) * 280,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(angle),
                    alignment: Alignment.center,
                    child: Opacity(
                      opacity: value.clamp(0.5, 1.0),
                      child: child,
                    ),
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 2,
                    offset: const Offset(0, 10),
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage(_artworks[index]['image']),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _artworks[index]['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _artworks[index]['artist'],
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.remove_red_eye, color: Colors.cyanAccent, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          _artworks[index]['views'],
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.favorite, color: Colors.pinkAccent, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          _artworks[index]['likes'],
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
