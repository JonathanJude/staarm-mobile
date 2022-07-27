
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ConfigReader {
  static Map<String, dynamic> _config;

  // static Future<void> initialize() async {
  //   final configString = await rootBundle.loadString('config/app_config.json');
  //   _config = json.decode(configString) as Map<String, dynamic>;
  // }

  static String getDevUrl() {
    return env['API_BASE_URL_DEV'];
    // return _config['API_BASE_URL_DEV'] as String;
    //testing workflow
  }

  static String getProdUrl(){
    return env['API_BASE_URL_PROD'];
    // return _config['API_BASE_URL_PROD'] as String;
  }
  static String getMapsApiKey(){
    return env['AIzaSyC8sFBzony7B9gXvzbohaKPmVX81MoZ6Wc'];
    // return _config['API_BASE_URL_PROD'] as String;
  }
}