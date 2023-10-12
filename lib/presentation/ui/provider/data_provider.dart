
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/news_model.dart';
import 'network_provider.dart';

class DataProvider {
  static final articleDataProvider = FutureProvider<List<ArticlesData>>((ref) async =>
      ref.watch(NetworkProvider.networkProvider).getRequest());
}