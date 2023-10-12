import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/services/api_services.dart';

class NetworkProvider
{
  static final networkProvider = Provider<ApiServices>((ref) => ApiServices());
}