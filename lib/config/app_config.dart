import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {

  static final String API_URL = dotenv.env['BASE_API_URL'] ?? '';

}