import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/trending_carousel.dart';
import '../widgets/featured_artists.dart';
import '../widgets/popular_collections.dart';
import '../widgets/floating_nav_bar.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main Scrollable Content
          SafeArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBar(),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Discover Amazing\nDigital Artworks',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
                  ),
                  const SizedBox(height: 30),
                  // Trending Now Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Trending Now',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          'See All',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                      ],
                    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
                  ),
                  const SizedBox(height: 15),
                  const TrendingCarousel().animate().fadeIn(delay: 300.ms).scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1)),
                  const SizedBox(height: 30),
                  
                  // Featured Artists Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Featured Artists',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.1, end: 0),
                  ),
                  const SizedBox(height: 15),
                  const FeaturedArtists().animate().fadeIn(delay: 500.ms),
                  const SizedBox(height: 30),

                  // Popular Collections Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Popular Collections',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ).animate().fadeIn(delay: 600.ms).slideX(begin: -0.1, end: 0),
                  ),
                  const SizedBox(height: 15),
                  PopularCollections(scrollController: _scrollController),
                  const SizedBox(height: 100), // Bottom padding for nav bar
                ],
              ),
            ),
          ),
          // Floating Navigation Bar
          const Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: FloatingNavBar(),
          ),
        ],
      ),
    );
  }
}
