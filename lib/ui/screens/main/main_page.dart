import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kids_app/services/dio_client.dart';
import 'package:kids_app/theme.dart';
import 'package:kids_app/ui/components/movie_card_component.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<dynamic> userMovies = [];

  @override
  void initState() {
    super.initState();
    _getCategoryList();
  }

  Future<void> _getCategoryList() async {
    try {
      final response = await dioClient.dio.get('/category/get_category');

      if (response.statusCode == 200) {
        setState(() {
          final List<dynamic> moviesList = response.data["data"] ?? [];
          userMovies = moviesList.map((movie) {
            return {
              "title": movie["category_name"] ?? "Bilinmeyen Kategori",
              "description": "Bu film hakkında açıklama bulunmamaktadır.",
              "duration": "- dk",
              "imageUrl":
                  movie["image_url"] ?? "https://example.com/default-image.jpg",
            };
          }).toList();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Giriş başarısız: ${response.data}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hata oluştu: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.secondBackgoundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 24.0, top: 24.0, right: 24.0, bottom: 5.0),
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
                                  icon: const Icon(Icons.layers,
                                      size: 20,
                                      color: AppTheme.primaryTextColor),
                                  label: const Text('Yeni Kategori'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        AppTheme.fourthBackgoundColor,
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
                                  icon: const Icon(Icons.tv,
                                      size: 20,
                                      color: AppTheme.secondBackgoundColor),
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
                      child: userMovies.isEmpty
                          ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: const Icon(
                                Icons.add_circle,
                                color: AppTheme.secondBackgoundColor,
                                size: 80,
                              ),
                              onTap: () {
                            context.router.replaceNamed('categoryNewCategoryPage');
                          },
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 12.0, left: 38.0, right: 38.0),
                                child: Text(
                                  'Henüz bir kategoriniz yok. Hemen oluşturmaya başla',
                                  textAlign: TextAlign.center,
                                  style: AppTheme.secondaryButtonText,
                                ),
                              ),
                            ),
                          ],
                        )
                          : CustomScrollView(
                              slivers: [
                                SliverToBoxAdapter(
                                  child: MainPageListCardComponent(
                                    title: 'Kategorileriniz',
                                    movies: userMovies,
                                  ),
                                ),
                                const SliverToBoxAdapter(
                                  child: SizedBox(height: 15), // Ek boşluk
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
  final List<dynamic> movies;

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
