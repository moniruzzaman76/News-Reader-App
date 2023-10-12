import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'data/offline_data/adaptars/article_data_adaptar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(ArticlesDataAdapter());
  await Hive.initFlutter();

  runApp(const ProviderScope(child: NewsReader()));
}
