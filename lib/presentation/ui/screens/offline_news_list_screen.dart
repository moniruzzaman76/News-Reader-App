import 'package:flutter/material.dart';
import '../../../data/models/news_model.dart';
import '../../../data/offline_data/offline_news_data.dart';
import '../widgets/news_card.dart';
import 'news_details_screen.dart';


class OfflineNewsListScreen extends StatelessWidget {
  const OfflineNewsListScreen({super.key,});

  @override
  Widget build(BuildContext context) {
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
                color: Colors.red,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text('Offline')
          ],
        ),
      ),
      body: FutureBuilder<List<ArticlesData>>(
        future: LocalDataStorage.getArticlesFromDatabase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error.toString()}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            final articlesDataList = snapshot.data;

            return ListView.builder(
              itemCount: articlesDataList?.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailsScreen(
                          article: articlesDataList[index],
                        ),
                      ),
                    );
                  },
                  child: NewsCard(
                    article: articlesDataList![index],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
