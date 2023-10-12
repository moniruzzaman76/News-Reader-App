import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/data_provider.dart';
import '../widgets/news_card.dart';
import 'news_details_screen.dart';

class OnlineNewsListScreen extends ConsumerWidget {
  const OnlineNewsListScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch(DataProvider.articleDataProvider);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Latest News'),
            const Spacer(),
            Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text('Online')
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          print("Refreshing data...");
          try {
            ref.refresh(DataProvider.articleDataProvider);
            print("Data refreshed!");
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Error refreshing data: $e"),
              ),
            );
          }
        },
        child: data.when(
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailsScreen(
                          article: data[index],
                        ),
                      ),
                    );
                  },
                  child: NewsCard(
                    article: data[index],
                  ),
                );
              },
            );
          },
          error: (error, _) => Text(error.toString()),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
