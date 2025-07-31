import 'package:path_provider/path_provider.dart';

abstract final class AppAssets {
  static const String logoIconImage = 'assets/images/logo-icon.png';
  static const String logoTextImage = 'assets/images/logo-text.png';

  static Future<String> getRecordingPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/recording.wav';
  }
}
