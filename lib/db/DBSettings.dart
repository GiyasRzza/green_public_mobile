import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class DBSettings{
  static Future<Database> openAppSettingsDB() async {
    const String dbName = 'green_public_local';
    final String appDocumentDir = await _getDbDirectory();
    final String dbPath = join(appDocumentDir, dbName);
    return await databaseFactoryIo.openDatabase(dbPath);
  }

  static Future<String> _getDbDirectory() async {
    final bool isMobile = await _isMobile();
    if (isMobile) {
      final directory = await getApplicationDocumentsDirectory();
      return directory.path;
    } else {
      return "memories";
    }
  }

  static Future<bool> _isMobile() async {
    return (Platform.isAndroid || Platform.isIOS);
  }
}
