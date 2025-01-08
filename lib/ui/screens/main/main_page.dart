import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kids_app/theme.dart';
import 'package:kids_app/ui/components/movie_card_component.dart';

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> moviesSuggest = [
      {
        'title': 'The Mystery of the Missing Marshmallows',
        'description':
            'A deliciously puzzling adventure where young sleuths must track down the trail of missing marshmallows from the campfire, unraveling clues and discovering tasty secrets along the way.',
        'duration': '90 dk',
        'imageUrl': 'https://img.youtube.com/vi/ZvodMMy43B8/maxresdefault.jpg',
      },
      {
        'title': 'Adventures in the Candyland',
        'description':
            'Join the magical journey through Candyland where surprises await at every corner!',
        'duration': '120 dk',
        'imageUrl': 'https://img.youtube.com/vi/Va7gnpMnaQ8/maxresdefault.jpg',
      },
      {
        'title': 'Treasure Hunt in the Jungle',
        'description':
            'Follow the treasure map to uncover mysteries and find hidden treasures in the jungle.',
        'duration': '110 dk',
        'imageUrl': 'https://img.youtube.com/vi/jfKfPfyJRdk/maxresdefault.jpg',
      },
    ];

    return Scaffold(
      backgroundColor: AppTheme.secondBackgoundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left:24.0, top:24.0, right:24.0, bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hoş Geldiniz',
                      style: AppTheme.onboardingSubTitle,
                    ),
                    Text(
                      'Profile182',
                      style: AppTheme.generalTitle.copyWith(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {
                    context.router.replaceNamed('settingsPage');
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.thirdBackgoundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Uygulamayı Özelleştir',
                                style: AppTheme.mainpageTitle,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Çocuğunuz için en iyisini siz seçin ve izlemeye başlayın.',
                                style: AppTheme.mainpageSubTitle,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    context.router
                                        .replaceNamed('categoryMainPage');
                                  },
                                  icon: const Icon(Icons.layers, size: 20),
                                  label: const Text('Yeni Kategori'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.fourthBackgoundColor,
                                    foregroundColor: AppTheme.primaryTextColor,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 20,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    context.router
                                        .replaceNamed('watchlistPage');
                                  },
                                  icon: const Icon(Icons.tv, size: 20),
                                  label: const Text('Yeni İzlem'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: const Color(0xFF4A4A4A),
                                    side: const BorderSide(
                                      color: Color(0xFF4A4A4A),
                                      width: 1,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 20,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: MainPageListCardComponent(
                              title: 'Önerilenler',
                              movies: moviesSuggest,
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: SizedBox(height: 15), // Ek boşluk
                          ),
                          SliverToBoxAdapter(
                            child: MainPageListCardComponent(
                              title: 'Popüler Filmler',
                              movies: moviesSuggest,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MainPageListCardComponent extends StatelessWidget {
  final String title;
  final List<Map<String, String>> movies;

  const MainPageListCardComponent({
    super.key,
    required this.title,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 1.0),
          child: Text(
            title,
            style: AppTheme.mainpageCategoryTitle,
          ),
        ),
        SizedBox(
          height: 320,
          child: MovieCardList(movies: movies),
        ),
      ],
    );
  }
}
